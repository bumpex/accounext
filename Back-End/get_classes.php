<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php';

try {
    $stmt = $pdo->query("SELECT num_Class AS id, nom FROM classes ORDER BY num_Class ASC");
    $classes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($classes);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>