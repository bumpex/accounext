<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'db.php'; 

$data = $_POST;
$client_id = $data['entity_id'] ?? null;
$date = $data['date'] ?? date('Y-m-d');
$montant = $data['montant'] ?? null;
$description = $data['description'] ?? '';

if (!$client_id || !$montant) {
    echo json_encode(['success' => false, 'message' => 'Client ID and amount required']);
    exit;
}

$justificatif = null;
if (isset($_FILES['justificatif'])) {
    $uploadDir = 'uploads/justificatifs/';
    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }

    $fileName = uniqid() . '_' . basename($_FILES['justificatif']['name']);
    $targetPath = $uploadDir . $fileName;

    if (move_uploaded_file($_FILES['justificatif']['tmp_name'], $targetPath)) {
        $justificatif = $targetPath;
    }
}

try {
    $pdo->beginTransaction();

    $query = "INSERT INTO client_transactions (client_id, date, montant, description, justificatif) 
              VALUES (:client_id, :date, :montant, :description, :justificatif)";
    $stmt = $pdo->prepare($query);
    $stmt->execute([
        ':client_id' => $client_id,
        ':date' => $date,
        ':montant' => $montant,
        ':description' => $description,
        ':justificatif' => $justificatif
    ]);

    $update = "UPDATE clients SET solde = solde - :montant WHERE id = :client_id";
    $stmt2 = $pdo->prepare($update);
    $stmt2->execute([
        ':montant' => $montant,
        ':client_id' => $client_id
    ]);

    $pdo->commit();

    echo json_encode([
        'success' => true,
        'message' => 'Transaction added successfully'
    ]);
} catch (Exception $e) {
    $pdo->rollBack();
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ]);
}
?>
