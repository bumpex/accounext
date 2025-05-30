<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'db.php'; 

try {
    $stmt = $pdo->query("SELECT id, nom, email, telephone, adresse, solde, description FROM fournisseurs");
    $clients = $stmt->fetchAll();

    echo json_encode([
        'success' => true,
        'data' => $clients
    ]);
} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => "Erreur lors de la récupération des clients: " . $e->getMessage()
    ]);
}
?>
