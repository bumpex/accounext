<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once '../config/db.php';

try {
    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data['name']) || !isset($data['age']) || !isset($data['profits'])) {
        http_response_code(400);
        echo json_encode(['message' => 'Missing required fields.']);
        exit;
    }

    $name = trim($data['name']);
    $age = (int)$data['age'];
    $profits = $data['profits']; // associative array: year => amount

    // Insert into entreprise
    $stmt = $pdo->prepare("INSERT INTO entreprise (name, age) VALUES (?, ?)");
    $stmt->execute([$name, $age]);
    $entrepriseId = $pdo->lastInsertId();

    // Insert profits
    $profitStmt = $pdo->prepare("INSERT INTO benefices (entreprise_id, annee, montant) VALUES (?, ?, ?)");

    foreach ($profits as $year => $amount) {
        $year = (int)$year;
        $amount = (float)$amount;
        $profitStmt->execute([$entrepriseId, $year, $amount]);
    }

    echo json_encode(['success' => true, 'message' => 'Entreprise and profits saved successfully.']);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error', 'error' => $e->getMessage()]);
}
