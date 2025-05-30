<?php
// php/get_items.php
require_once 'config.php';

header('Content-Type: application/json');

$response = ['success' => false, 'message' => '', 'items' => []];

$item_type = isset($_GET['type']) ? $_GET['type'] : '';
$category_filter = isset($_GET['category']) ? $_GET['category'] : '';
$location_filter = isset($_GET['location']) ? $_GET['location'] : '';
$user_id_filter = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;

// ADD THIS NEW LINE:
$show_all = isset($_GET['show_all']) && $_GET['show_all'] === 'true'; // New parameter for admin/full listings

$sql = "SELECT i.*, u.name as user_name FROM items i JOIN users u ON i.user_id = u.id WHERE 1=1";
$params = [];
$types = "";

if (!empty($item_type)) {
    $sql .= " AND i.type = ?";
    $params[] = $item_type;
    $types .= "s";
}
if (!empty($category_filter)) {
    $sql .= " AND i.category LIKE ?";
    $params[] = "%" . $category_filter . "%";
    $types .= "s";
}
if (!empty($location_filter)) {
    $sql .= " AND i.location LIKE ?";
    $params[] = "%" . $location_filter . "%";
    $types .= "s";
}
if ($user_id_filter > 0) {
    $sql .= " AND i.user_id = ?";
    $params[] = $user_id_filter;
    $types .= "i";
} elseif (!$show_all) { // Apply status filter ONLY if not showing all AND not a specific user's dashboard
    $sql .= " AND (i.status = 'active' OR i.status = 'claimed')";
}

$sql .= " ORDER BY i.created_at DESC"; // Order by most recent

if ($stmt = mysqli_prepare($conn, $sql)) {
    if (!empty($params)) {
        mysqli_stmt_bind_param($stmt, $types, ...$params);
    }

    if (mysqli_stmt_execute($stmt)) {
        $result = mysqli_stmt_get_result($stmt);
        $items = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $items[] = $row;
        }
        $response['success'] = true;
        $response['items'] = $items;
    } else {
        $response['message'] = 'Error fetching items: ' . mysqli_error($conn);
    }
    mysqli_stmt_close($stmt);
} else {
    $response['message'] = 'Database query preparation failed: ' . mysqli_error($conn);
}

echo json_encode($response);
mysqli_close($conn);
?>