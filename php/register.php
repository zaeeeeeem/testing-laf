<?php
// php/register.php
require_once 'config.php';

header('Content-Type: application/json');

$response = ['success' => false, 'message' => ''];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    $password = $_POST['password']; // No hashing for speed
    $role = 'user'; // Default role

    // Simple validation
    if (empty($name) || empty($email) || empty($password)) {
        $response['message'] = 'All fields are required.';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $response['message'] = 'Invalid email format.';
    } else {
        // Check if email already exists
        $sql = "SELECT id FROM users WHERE email = ?";
        if ($stmt = mysqli_prepare($conn, $sql)) {
            mysqli_stmt_bind_param($stmt, "s", $param_email);
            $param_email = $email;
            if (mysqli_stmt_execute($stmt)) {
                mysqli_stmt_store_result($stmt);
                if (mysqli_stmt_num_rows($stmt) == 1) {
                    $response['message'] = 'This email is already registered.';
                } else {
                    // Insert new user
                    $sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
                    if ($stmt_insert = mysqli_prepare($conn, $sql)) {
                        mysqli_stmt_bind_param($stmt_insert, "ssss", $param_name, $param_email, $param_password, $param_role);
                        $param_name = $name;
                        $param_email = $email;
                        $param_password = $password; // Storing plain text for speed
                        $param_role = $role;

                        if (mysqli_stmt_execute($stmt_insert)) {
                            $response['success'] = true;
                            $response['message'] = 'Registration successful!';
                            // Optionally log the user in directly
                            $_SESSION['user_id'] = mysqli_insert_id($conn);
                            $_SESSION['user_name'] = $name;
                            $_SESSION['user_role'] = $role;
                        } else {
                            $response['message'] = 'Something went wrong. Please try again later.';
                        }
                        mysqli_stmt_close($stmt_insert);
                    }
                }
            } else {
                $response['message'] = 'Oops! Something went wrong with email check.';
            }
            mysqli_stmt_close($stmt);
        }
    }
} else {
    $response['message'] = 'Invalid request method.';
}

echo json_encode($response);
mysqli_close($conn);
?>