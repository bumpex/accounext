<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

include '../config/db.php';

try {
    $classId = $_GET['class_id'] ?? null;

    $sql = "SELECT 
                numero_compte AS NumeroCompte,
                nom_compte AS NomCompte,
                montant_debit AS debit,
                montant_credit AS credit
            FROM comptes";

    if ($classId !== null && is_numeric($classId)) {
        $sql .= " WHERE class_id = ?";
    }

    $stmt = $pdo->prepare($sql);

    if ($classId !== null && is_numeric($classId)) {
        $stmt->execute([$classId]);
    } else {
        $stmt->execute();
    }

    $comptes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($comptes);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>