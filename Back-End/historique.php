<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
require_once 'db.php';

try {
    $stmt = $pdo->query("
        SELECT date_operation, libelle, montant, type 
        FROM entries 
        ORDER BY created_at DESC 
        LIMIT 4
    ");
    $entries = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'success' => true,
        'data' => $entries ?: []
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>