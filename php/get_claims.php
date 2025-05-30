<?php
// php/get_claims.php
require_once 'config.php';

header('Content-Type: application/json');

$response = ['success' => false, 'message' => '', 'claims' => []];

if (!isset($_SESSION['user_id'])) {
    $response['message'] = 'User not logged in.';
    echo json_encode($response);
    exit;
}

$user_id = $_SESSION['user_id'];
$type = isset($_GET['type']) ? $_GET['type'] : ''; // 'my_claims' or 'claims_on_my_items'

$sql = "";
$params = [$user_id];
$types = "i";

if ($type === 'my_claims') {
    // Claims made by the current user
    $sql = "SELECT c.*, i.name as item_name, i.image_url, i.type as item_type, u.name as finder_name, u.email as finder_email
            FROM claims c
            JOIN items i ON c.item_id = i.id
            JOIN users u ON i.user_id = u.id
            WHERE c.claimer_id = ? ORDER BY c.created_at DESC";
} elseif ($type === 'claims_on_my_items') {
    // Claims on items posted by the current user
    $sql = "SELECT c.*, i.name as item_name, i.image_url, i.type as item_type, u.name as claimer_name, u.email as claimer_email
            FROM claims c
            JOIN items i ON c.item_id = i.id
            JOIN users u ON c.claimer_id = u.id
            WHERE i.user_id = ? ORDER BY c.created_at DESC";
} else {
    $response['message'] = 'Invalid claim type specified.';
    echo json_encode($response);
    exit;
}

if ($stmt = mysqli_prepare($conn, $sql)) {
    mysqli_stmt_bind_param($stmt, $types, ...$params);
    if (mysqli_stmt_execute($stmt)) {
        $result = mysqli_stmt_get_result($stmt);
        $claims = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $claims[] = $row;
        }
        $response['success'] = true;
        $response['claims'] = $claims;
    } else {
        $response['message'] = 'Error fetching claims: ' . mysqli_error($conn);
    }
    mysqli_stmt_close($stmt);
} else {
    $response['message'] = 'Database query preparation failed: ' . mysqli_error($conn);
}

echo json_encode($response);
mysqli_close($conn);
?>