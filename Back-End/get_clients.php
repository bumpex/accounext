<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

include '../config/db.php';


try {
    $stmt = $pdo->query("SELECT nom AS name, solde AS amount FROM clients");
    $clients = $stmt->fetchAll();
    echo json_encode($clients);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Query failed: ' . $e->getMessage()]);
}
