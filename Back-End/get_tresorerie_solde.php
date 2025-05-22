<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

try {
    include '../config/db.php';

    $stmt = $pdo->query("SELECT banque, caisse FROM tresorerie_solde ORDER BY updated_at DESC LIMIT 1");
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($row) {
        echo json_encode([
            'total' => round($row['banque'] + $row['caisse'], 2),
            'details' => [
                ['nom_compte' => 'Banque', 'solde' => round($row['banque'], 2)],
                ['nom_compte' => 'Caisse', 'solde' => round($row['caisse'], 2)]
            ]
        ]);
    } else {
        echo json_encode(['total' => 0, 'details' => []]);
    }

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>