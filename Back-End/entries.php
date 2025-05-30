<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
$host = 'localhost';
$dbname = 'accounext';
$username = 'root';
$password = ''; // adjust if your DB has a password
$conn = new mysqli($host, $username, $password, $dbname);
if ($conn->connect_error) {
    echo json_encode([
        'success' => false,
        'error' => 'Database connection failed: ' . $conn->connect_error
    ]);
    exit;
}
$sql = "SELECT id, journal_entry_id, compteNum, compteNom, montant, type, date_operation, libelle, justification FROM entries ORDER BY date_operation DESC, id ASC";
$result = $conn->query($sql);

if (!$result) {
    echo json_encode([
        'success' => false,
        'error' => 'Query failed: ' . $conn->error
    ]);
    exit;
}
$entries = [];
while ($row = $result->fetch_assoc()) {
    $entries[] = $row;
}
echo json_encode([
    'success' => true,
    'data' => $entries
]);

$conn->close();
