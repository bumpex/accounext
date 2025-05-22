<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once '../config/db.php'; // Your PDO connection file

try {
    // Get the JSON input
    $data = json_decode(file_get_contents("php://input"), true);

    // Validate required fields
    if (
        !isset($data['numero_compte']) || empty(trim($data['numero_compte'])) ||
        !isset($data['nom_compte']) || empty(trim($data['nom_compte']))
    ) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Les champs numero_compte et nom_compte sont obligatoires.']);
        exit;
    }

    // Prepare variables
    $numero_compte = trim($data['numero_compte']);
    $nom_compte = trim($data['nom_compte']);
    $montant_debit = isset($data['montant_debit']) ? floatval($data['montant_debit']) : 0;
    $montant_credit = isset($data['montant_credit']) ? floatval($data['montant_credit']) : 0;

    // Prepare insert statement
    $stmt = $pdo->prepare("INSERT INTO comptes (numero_compte, nom_compte, montant_debit, montant_credit) VALUES (?, ?, ?, ?)");

    // Execute insert
    $stmt->execute([$numero_compte, $nom_compte, $montant_debit, $montant_credit]);

    echo json_encode(['success' => true, 'message' => 'Compte enregistré avec succès.']);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Erreur serveur.', 'error' => $e->getMessage()]);
}


