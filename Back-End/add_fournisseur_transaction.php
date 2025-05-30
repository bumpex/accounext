<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'db.php'; 

$fournisseur_id = $_POST['entity_id'] ?? null;
$date = $_POST['date'] ?? date('Y-m-d');
$montant = $_POST['montant'] ?? null;
$description = $_POST['description'] ?? '';

if (!$fournisseur_id || !$montant) {
    echo json_encode(['success' => false, 'message' => 'Fournisseur ID and amount required']);
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

    $query = "INSERT INTO fournisseur_transactions 
              (fournisseur_id, date, montant, description, justificatif) 
              VALUES (:fournisseur_id, :date, :montant, :description, :justificatif)";
    $stmt = $pdo->prepare($query);
    $stmt->execute([
        ':fournisseur_id' => $fournisseur_id,
        ':date' => $date,
        ':montant' => $montant,
        ':description' => $description,
        ':justificatif' => $justificatif
    ]);

    $update = "UPDATE fournisseurs SET solde = solde + :montant WHERE id = :id";
    $stmt2 = $pdo->prepare($update);
    $stmt2->execute([
        ':montant' => $montant,
        ':id' => $fournisseur_id
    ]);

    $pdo->commit();

    echo json_encode([
        'success' => true,
        'message' => 'Transaction added successfully'
    ]);
} catch (PDOException $e) {
    $pdo->rollBack();
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ]);
}
?>
