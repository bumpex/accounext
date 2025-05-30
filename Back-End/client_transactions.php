<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'db.php'; 

$client_id = $_GET['id'] ?? null;

if (!$client_id) {
    echo json_encode(['success' => false, 'message' => 'Client ID required']);
    exit;
}

try {
    $query = "SELECT id, date, montant, description, justificatif 
              FROM client_transactions 
              WHERE client_id = :client_id 
              ORDER BY date DESC";

    $stmt = $pdo->prepare($query);
    $stmt->execute([':client_id' => $client_id]);

    $transactions = $stmt->fetchAll();

    echo json_encode([
        'success' => true,
        'data' => $transactions
    ]);
} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
?>
