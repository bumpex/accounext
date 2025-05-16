<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

include '../config/db.php';

// Read JSON input
$data = json_decode(file_get_contents("php://input"), true);

// Basic validation
$email = trim($data['email'] ?? '');
$password = $data['password'] ?? '';

if (!$email || !$password) {
    echo json_encode(['success' => false, 'error' => 'Email and password are required']);
    exit;
}

try {
    // Look up user
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    // Check password
    if ($user && password_verify($password, $user['password'])) {
        echo json_encode([
            'success' => true,
            'user' => [
                'id' => $user['id'],
                'full_name' => $user['full_name'],
                'email' => $user['email']
            ]
        ]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Invalid email or password']);
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => 'Server error: ' . $e->getMessage()]);
}





?>