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

    // Get account number from query parameter
    $accountNumber = $_GET['accountNumber'] ?? '';
    if (empty($accountNumber)) {
        respond(false, 'Numéro de compte est requis');
    }

    // Get account information
    $stmt = $pdo->prepare("
        SELECT numero_compte, nom_compte, montant_debit, montant_credit 
        FROM comptes 
        WHERE numero_compte = ?
    ");
    $stmt->execute([$accountNumber]);
    $account = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$account) {
        respond(false, 'Compte non trouvé');
    }

    // Get all transactions for this account
    $transactionsStmt = $pdo->prepare("
        SELECT 
            date_operation as date,
            libelle,
            CASE WHEN type = 'debit' THEN montant ELSE 0 END as debit,
            CASE WHEN type = 'credit' THEN montant ELSE 0 END as credit
        FROM entries
        WHERE compteNum = ?
        ORDER BY date_operation ASC, created_at ASC
    ");
    $transactionsStmt->execute([$accountNumber]);
    $transactions = $transactionsStmt->fetchAll(PDO::FETCH_ASSOC);

    // Calculate totals from daily operations
    $totalDailyDebit = 0;
    $totalDailyCredit = 0;
    
    foreach ($transactions as $transaction) {
        $totalDailyDebit += (float)$transaction['debit'];
        $totalDailyCredit += (float)$transaction['credit'];
    }

    // Calculate initial balance by subtracting daily operations from current balance
    $initialDebit = max(0, (float)$account['montant_debit'] - $totalDailyDebit);
    $initialCredit = max(0, (float)$account['montant_credit'] - $totalDailyCredit);

    // Calculate current totals
    $totalDebit = $initialDebit + $totalDailyDebit;
    $totalCredit = $initialCredit + $totalDailyCredit;

    // Determine balance status
    $balance = abs($totalDebit - $totalCredit);
    $balanceType = ($totalDebit > $totalCredit) ? 'débiteur' : 'créditeur';

    // Prepare response
    $response = [
        'accountNumber' => $account['numero_compte'],
        'accountName' => $account['nom_compte'],
        'initialDebit' => $initialDebit,
        'initialCredit' => $initialCredit,
        'transactions' => [],
        'totalDebit' => $totalDebit,
        'totalCredit' => $totalCredit,
        'balance' => $balance,
        'balanceType' => $balanceType,
        'totalDailyDebit' => $totalDailyDebit,
        'totalDailyCredit' => $totalDailyCredit
    ];

    // Add initial balance as first transaction
    $response['transactions'][] = [
        'date' => '',
        'libelle' => 'Solde initial',
        'debit' => $initialDebit > 0 ? number_format($initialDebit, 2, '.', '') : '',
        'credit' => $initialCredit > 0 ? number_format($initialCredit, 2, '.', '') : ''
    ];

    // Add all other transactions
    foreach ($transactions as $transaction) {
        $response['transactions'][] = [
            'date' => $transaction['date'],
            'libelle' => $transaction['libelle'],
            'debit' => $transaction['debit'] > 0 ? number_format($transaction['debit'], 2, '.', '') : '',
            'credit' => $transaction['credit'] > 0 ? number_format($transaction['credit'], 2, '.', '') : ''
        ];
    }

    respond(true, 'Données récupérées avec succès', $response);

} catch (Exception $e) {
    respond(false, 'Erreur: ' . $e->getMessage());
}