<?php
header('Access-Control-Allow-Origin: http://localhost:3000'); 
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit;
}

$host = 'localhost';
$db   = 'accounext';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    echo json_encode([
        'status' => 'error',
        'message' => 'Échec de la connexion à la base de données: ' . $e->getMessage()
    ]);
    exit;
}

$Nom         = $_POST['Nom'] ?? '';
$Email       = $_POST['Email'] ?? '';
$Telephone    = $_POST['Telephone'] ?? '';
$Adresse     = $_POST['Adresse'] ?? '';
$Solde       = $_POST['Solde'] ?? 0;
$Description = $_POST['Description'] ?? '';

if (empty($Nom) || empty($Telephone)) {
    echo json_encode([
        'status' => 'error',
        'message' => 'Veuillez remplir les champs obligatoires (Nom et Téléphone).'
    ]);
    exit;
}

try {
    
    $stmt = $pdo->prepare("INSERT INTO clients (nom, email, telephone, adresse, solde, description) 
                           VALUES (?, ?, ?, ?, ?, ?)");

   
    $stmt->execute([$Nom, $Email, $Telephone, $Adresse, $Solde, $Description]);

    
    echo json_encode([
        'status' => 'success',
        'message' => 'Client ajouté avec succès.'
    ]);
} catch (Exception $e) {
    echo json_encode([
        'status' => 'error',
        'message' => 'Erreur lors de l\'insertion: ' . $e->getMessage()
    ]);
}
?>
