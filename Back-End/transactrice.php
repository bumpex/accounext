<?php

header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");

require_once 'db.php';

function respond($success, $message, $data = []) {
    echo json_encode([
        'success' => $success,
        'message' => $message,
        'data' => $data
    ]);
    exit;
}

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        respond(false, 'Méthode non autorisée');
    }
    $searchTerm = $_GET['search'] ?? '';
    $filterDate = $_GET['date'] ?? '';
    $query = "SELECT id, date_operation, libelle, montant, type FROM entries";
    $conditions = [];
    $params = [];
    if (!empty($searchTerm)) {
        $conditions[] = "(libelle LIKE ? OR montant LIKE ?)";
        $searchParam = "%$searchTerm%";
        array_push($params, $searchParam, $searchParam);
    }
    if (!empty($filterDate)) {
        $conditions[] = "date_operation = ?";
        $params[] = $filterDate;
    }
    if (!empty($conditions)) {
        $query .= " WHERE " . implode(" AND ", $conditions);
    }
    $query .= " ORDER BY date_operation DESC, id DESC";
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);
    $transactions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    array_walk($transactions, function(&$transaction) {
        $transaction['montant'] = number_format((float)$transaction['montant'], 2, '.', '');
        $transaction['type'] = $transaction['type'] === 'debit' ? 'Débit' : 'Crédit';
    });

    respond(true, 'Transactions récupérées avec succès', $transactions);

} catch (Exception $e) {
    respond(false, 'Erreur: ' . $e->getMessage());
}