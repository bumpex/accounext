<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include '../config/db.php';

try {
    $stmt = $pdo->query("SELECT id, numero_compte, nom_compte, class_id FROM comptes");
    $accounts = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(['success' => true, 'data' => $accounts]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}



?>