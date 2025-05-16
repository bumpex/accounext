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

    // Get search parameters from query string
    $searchTerm = $_GET['search'] ?? '';
    $filterDate = $_GET['date'] ?? '';

    // Prepare the base query
    $query = "SELECT id, date_operation, libelle, montant, type FROM entries";
    $conditions = [];
    $params = [];

    // Add search condition if search term exists
    if (!empty($searchTerm)) {
        $conditions[] = "(libelle LIKE ? OR montant LIKE ?)";
        $searchParam = "%$searchTerm%";
        array_push($params, $searchParam, $searchParam);
    }

    // Add date filter condition if date exists
    if (!empty($filterDate)) {
        $conditions[] = "date_operation = ?";
        $params[] = $filterDate;
    }

    // Combine conditions if any exist
    if (!empty($conditions)) {
        $query .= " WHERE " . implode(" AND ", $conditions);
    }

    // Add sorting by date (newest first)
    $query .= " ORDER BY date_operation DESC, id DESC";

    // Prepare and execute the query
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);

    // Fetch all results
    $transactions = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Format the amounts with 2 decimal places and add debit/credit indicator
    array_walk($transactions, function(&$transaction) {
        $transaction['montant'] = number_format((float)$transaction['montant'], 2, '.', '');
        $transaction['type'] = $transaction['type'] === 'debit' ? 'Débit' : 'Crédit';
    });

    respond(true, 'Transactions récupérées avec succès', $transactions);

} catch (Exception $e) {
    respond(false, 'Erreur: ' . $e->getMessage());
}