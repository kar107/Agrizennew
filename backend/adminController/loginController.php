<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include '../utility/object.php';

// Handle preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$response = array();

// ✅ insert_myactivity function using PDO
function insert_myactivity($user_id, $name, $message) {
    try {
        $pdo = new PDO("mysql:host=localhost;dbname=agrizen", "root", "");
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $stmt = $pdo->prepare("INSERT INTO notifications (user_id, name, message, created_at) VALUES (?, ?, ?, ?)");
        $stmt->execute([
            $user_id,
            $name,
            $message,
            date("Y-m-d H:i:s")
        ]);
    } catch (PDOException $e) {
        error_log("insert_myactivity error: " . $e->getMessage());
    }
}

// ✅ Main login logic
if (isset($_POST['tag']) && $_POST['tag'] == "login") {
    $email = trim($_POST['email']);
    $password = trim($_POST['password']);

    if (!empty($email) && !empty($password)) {
        $s = $d->select('users', "email = '$email'");

        if (mysqli_num_rows($s) > 0) {
            $user = mysqli_fetch_assoc($s);

            if (password_verify($password, $user['password_hash'])) {
                $_SESSION['userid'] = $user['userid'];
                $_SESSION['role'] = $user['role'];

                // ✅ Insert login activity
                insert_myactivity($user['userid'], "Login Successful", "{$user['name']} logged in successfully.");

                $response['message'] = 'Login successful';
                $response['status'] = '200';
                $response['data'] = [
                    'userid' => $user['userid'],
                    'name' => $user['name'],
                    'email' => $user['email'],
                    'role' => $user['role'],
                    'created_at' => $user['created_at']
                ];
            } else {
                $response['message'] = 'Invalid password';
                $response['status'] = '401';
            }
        } else {
            $response['message'] = 'User not found';
            $response['status'] = '404';
        }
    } else {
        $response['message'] = 'Email and password are required';
        $response['status'] = '400';
    }
} else {
    $response['message'] = 'Invalid request';
    $response['status'] = '400';
}

echo json_encode($response);
exit;
