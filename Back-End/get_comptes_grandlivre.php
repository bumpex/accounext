<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php';

try {
    $query = $_GET['query'] ?? '';

    $sql = "SELECT 
                numero_compte AS NumeroCompte,
                nom_compte AS NomCompte,
                montant_debit AS debit,
                montant_credit AS credit
            FROM comptes";

    if (!empty($query)) {
        $sql .= " WHERE numero_compte LIKE :query OR nom_compte LIKE :query";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([':query' => "%$query%"]);
    } else {
        $stmt = $pdo->prepare($sql);
        $stmt->execute();
    }

    $comptes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($comptes);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>