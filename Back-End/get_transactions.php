<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");

include '../config/db.php';

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

    // Get search parameters
    $searchTerm = $_GET['search'] ?? '';
    $filterDate = $_GET['date'] ?? '';

    // Base query
    $query = "SELECT id, date_operation, compteNum, compteNom, montant, type FROM entries";
    $conditions = [];
    $params = [];

    // Add search condition
    if (!empty($searchTerm)) {
        $conditions[] = "(compteNum LIKE ? OR compteNom LIKE ?)";
        $searchParam = "%$searchTerm%";
        array_push($params, $searchParam, $searchParam);
    }

    // Add date filter
    if (!empty($filterDate)) {
        $conditions[] = "date_operation = ?";
        $params[] = $filterDate;
    }

    // Build WHERE clause
    if (!empty($conditions)) {
        $query .= " WHERE " . implode(" AND ", $conditions);
    }

    // Sort by most recent
    $query .= " ORDER BY date_operation DESC";

    // Prepare and execute
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);

    // Format results
    $transactions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    array_walk($transactions, function (&$t) {
        $t['montant'] = (float)$t['montant'];
        $t['type'] = $t['type'] === 'debit' ? 'Débit' : 'Crédit';
    });

    respond(true, 'Transactions récupérées avec succès', $transactions);

} catch (Exception $e) {
    respond(false, 'Erreur serveur: ' . $e->getMessage());
}
?>