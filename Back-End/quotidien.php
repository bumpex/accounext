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

function generateUuid() {
    return sprintf('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
        mt_rand(0, 0xffff), mt_rand(0, 0xffff),
        mt_rand(0, 0xffff),
        mt_rand(0, 0x0fff) | 0x4000,
        mt_rand(0, 0x3fff) | 0x8000,
        mt_rand(0, 0xffff), mt_rand(0, 0xffff), mt_rand(0, 0xffff)
    );
}

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        respond(false, 'Méthode non autorisée');
    }

    $contentType = isset($_SERVER['CONTENT_TYPE']) ? $_SERVER['CONTENT_TYPE'] : '';
    
    // Initialize variables
    $date = date('Y-m-d');
    $libelle = '';
    $entries = [];
    $justification = null;

    if (strpos($contentType, 'multipart/form-data') !== false) {
        // Handle multipart form data (file upload)
        $date = $_POST['date'] ?? $date;
        $libelle = $_POST['libelle'] ?? '';
        
        // Parse entries from JSON string
        if (isset($_POST['entries']) && !empty($_POST['entries'])) {
            $entries = json_decode($_POST['entries'], true);
            if (json_last_error() !== JSON_ERROR_NONE) {
                respond(false, 'Format des entrées invalide');
            }
        }
        
        $justification = $_FILES['justification'] ?? null;
    } else {
        // Handle JSON data
        $input = file_get_contents('php://input');
        $data = json_decode($input, true);
        if (json_last_error() !== JSON_ERROR_NONE) {
            respond(false, 'Format JSON invalide');
        }
        
        $date = $data['date'] ?? $date;
        $libelle = $data['libelle'] ?? '';
        $entries = $data['entries'] ?? [];
        $justification = $data['justification'] ?? null;
    }

    // Validate required fields
    if (empty($libelle) || count($entries) === 0) {
        respond(false, 'Libellé et entrées sont requis');
    }

    // Validate each entry
    foreach ($entries as $entry) {
        if (empty($entry['compteNum']) || empty($entry['compteNom']) || 
            empty($entry['montant']) || !isset($entry['type'])) {
            respond(false, 'Tous les champs des entrées sont obligatoires');
        }
        if (!is_numeric($entry['montant']) || $entry['montant'] <= 0) {
            respond(false, 'Montant doit être un nombre positif');
        }
        if (!in_array($entry['type'], ['debit', 'credit'])) {
            respond(false, 'Type doit être debit ou credit');
        }
    }

    $justificationPath = null;
    if ($justification && isset($justification['error']) && $justification['error'] === UPLOAD_ERR_OK) {
        $uploadDir = __DIR__ . '/uploads/justifications/';
        if (!file_exists($uploadDir)) {
            mkdir($uploadDir, 0755, true);
        }

        $allowedTypes = ['image/jpeg', 'image/png', 'application/pdf'];
        $maxSize = 5 * 1024 * 1024; // 5MB

        if (!in_array($justification['type'], $allowedTypes)) {
            respond(false, 'Type de fichier non autorisé');
        }

        if ($justification['size'] > $maxSize) {
            respond(false, 'Fichier trop volumineux (max 5MB)');
        }

        $extension = pathinfo($justification['name'], PATHINFO_EXTENSION);
        $filename = uniqid('justif_') . '.' . $extension;
        $targetPath = $uploadDir . $filename;

        if (!move_uploaded_file($justification['tmp_name'], $targetPath)) {
            respond(false, 'Échec du téléchargement');
        }

        $justificationPath = 'uploads/justifications/' . $filename;
    }

    $pdo->beginTransaction();

    try {
        // Generate a unique ID for this journal entry
        $journalEntryId = generateUuid();
        
        $stmt = $pdo->prepare("
            INSERT INTO entries 
            (journal_entry_id, compteNum, compteNom, montant, type, date_operation, libelle, justification) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ");

        foreach ($entries as $entry) {
            // First insert the entry
            $success = $stmt->execute([
                $journalEntryId,
                $entry['compteNum'],
                $entry['compteNom'],
                $entry['montant'],
                $entry['type'],
                $date,
                $libelle,
                $justificationPath
            ]);

            if (!$success) {
                $error = $stmt->errorInfo();
                throw new Exception("Insertion échouée: " . $error[2]);
            }

            // Then update the account balance
            $updateStmt = $pdo->prepare("
                UPDATE comptes 
                SET montant_" . ($entry['type'] === 'debit' ? 'debit' : 'credit') . " = 
                    montant_" . ($entry['type'] === 'debit' ? 'debit' : 'credit') . " + ?,
                    updated_at = NOW()
                WHERE numero_compte = ?
            ");
            
            $updateSuccess = $updateStmt->execute([
                $entry['montant'],
                $entry['compteNum']
            ]);
            
            if (!$updateSuccess) {
                $error = $updateStmt->errorInfo();
                throw new Exception("Balance update failed: " . $error[2]);
            }
        }

        $pdo->commit();
        respond(true, 'Enregistrement réussi', [
            'journal_entry_id' => $journalEntryId,
            'date' => $date,
            'libelle' => $libelle,
            'entries_count' => count($entries),
            'justification' => $justificationPath
        ]);

    } catch (Exception $e) {
        $pdo->rollBack();
        respond(false, 'Erreur: ' . $e->getMessage());
    }

} catch (Exception $e) {
    respond(false, 'Erreur fatale: ' . $e->getMessage());
}