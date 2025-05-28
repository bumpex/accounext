<?php
header("Access-Control-Allow-Origin: http://localhost:3000");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
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

    // Insert into entreprise (note: column names are `nom` and `age_annee`)
    $stmt = $pdo->prepare("INSERT INTO entreprise (nom, age_annee) VALUES (?, ?)");
    $stmt->execute([$name, $age]);
    $entrepriseId = $pdo->lastInsertId();

    // Check if benefices table has entreprise_id field:
    // ⚠️ From your SQL dump, it doesn't — so this will fail unless you've modified it.
    foreach ($profits as $year => $amount) {
        $year = (int)$year;
        $amount = (float)$amount;

        // Only proceed if `benefices` actually supports `entreprise_id`
        // Otherwise, remove that field from the INSERT below
        $profitStmt = $pdo->prepare("INSERT INTO benefices (annee, montant) VALUES (?, ?)");
        $profitStmt->execute([$year, $amount]);
    }

    echo json_encode([
        'success' => true,
        'message' => 'Entreprise saved successfully.',
        'entreprise_id' => $entrepriseId
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error',
        'error' => $e->getMessage()
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Server error',
        'error' => $e->getMessage()
    ]);
}