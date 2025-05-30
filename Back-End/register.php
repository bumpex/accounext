<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); 
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');
require_once '../config/db.php';
$rawData = file_get_contents("php://input");
$data = json_decode($rawData, true);
if (
    empty($data['full_name']) ||
    empty($data['email']) ||
    empty($data['password'])
) {
    echo json_encode(["success" => false, "error" => "All fields are required"]);
    exit;
}

$fullName = $data['full_name'];
$email = $data['email'];
$password = password_hash($data['password'], PASSWORD_DEFAULT);

try {
    $stmt = $pdo->prepare("SELECT id FROM users WHERE Email = ?");
    $stmt->execute([$email]);

    if ($stmt->rowCount() > 0) {
        echo json_encode(["success" => false, "error" => "Email already registered"]);
        exit;
    }
    $stmt = $pdo->prepare("INSERT INTO users (Full_Name, Email, Password) VALUES (?, ?, ?)");
    $stmt->execute([$fullName, $email, $password]);

    echo json_encode(["success" => true]);
} catch (PDOException $e) {
    echo json_encode(["success" => false, "error" => "Database error: " . $e->getMessage()]);
}
