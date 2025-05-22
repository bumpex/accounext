<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

try {
    include '../config/db.php';

    // Fetch all profits from benefices table
    $stmt = $pdo->query("
        SELECT annee, montant 
        FROM benefices 
        ORDER BY annee ASC 
        LIMIT 5
    ");
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    
    $formattedData = array_map(function ($row) {
        return [
            'month' => (string)$row['annee'],
            'Debit' => 0,
            'Credit' => (float)$row['montant']
        ];
    }, $data);

    echo json_encode($formattedData);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>