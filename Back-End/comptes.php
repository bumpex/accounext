<?php
session_start();

header("Access-Control-Allow-Origin: http://localhost:3000"); // React frontend
header("Access-Control-Allow-Credentials: true"); // Let cookies through
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// User auth check
if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode([
        'success' => false,
        'message' => "Utilisateur non authentifié."
    ]);
    exit;
}


$userId = intval($_SESSION['user_id']);

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/db.php';

try {
    $data = json_decode(file_get_contents("php://input"), true);

    // Validate required fields
    $requiredFields = ['numero_compte', 'nom_compte', 'class_id'];
    foreach ($requiredFields as $field) {
        if (!isset($data[$field]) || trim($data[$field]) === '') {
            http_response_code(400);
            echo json_encode([
                'success' => false,
                'message' => "Le champ '$field' est obligatoire."
            ]);
            exit;
        }
    }

    // Sanitize input
    $numero_compte = trim($data['numero_compte']);
    $nom_compte = trim($data['nom_compte']);
    $class_id = intval($data['class_id']);
    $montant_debit = isset($data['montant_debit']) ? floatval($data['montant_debit']) : 0.0;
    $montant_credit = isset($data['montant_credit']) ? floatval($data['montant_credit']) : 0.0;


    // Insert into user-specific table
    $stmt = $pdo->prepare("
        INSERT INTO user_comptes (
            user_id,
            numero_compte,
            nom_compte,
            class_id,
            montant_debit,
            montant_credit
        ) VALUES (?, ?, ?, ?, ?, ?)
    ");

    $stmt->execute([
        $userId,
        $numero_compte,
        $nom_compte,
        $class_id,
        $montant_debit,
        $montant_credit
    ]);

    echo json_encode([
        'success' => true,
        'message' => 'Compte enregistré avec succès.'
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Erreur serveur. Impossible d\'enregistrer le compte.',
        'error' => $e->getMessage()
    ]);
}