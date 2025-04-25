<?php
// Error reporting
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

// Handle preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit();
}

$method = $_SERVER['REQUEST_METHOD'];

try {
    $pdo = new PDO("mysql:host=localhost;dbname=agrizen", "root", "");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo json_encode(["status" => 500, "message" => "Database connection failed: " . $e->getMessage()]);
    exit();
}

// ✅ GET METHOD — fetch all notifications
if ($method === 'GET') {
    try {
        $stmt = $pdo->prepare("SELECT notification_id, name, message, is_read, created_at FROM notifications ORDER BY created_at DESC");
        $stmt->execute();

        $notifications = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if (!$notifications) {
            echo json_encode(["status" => 404, "message" => "No notifications found."]);
        } else {
            echo json_encode($notifications); // Directly returning the notifications data as JSON
        }
    } catch (PDOException $e) {
        echo json_encode(["status" => 500, "message" => "Database error: " . $e->getMessage()]);
    }
    exit();
}

// ✅ DELETE METHOD — delete notification by notification_id
if ($method === 'DELETE') {
    $notification_id = $_GET['notification_id'] ?? null;

    if (!$notification_id) {
        echo json_encode(["status" => 400, "message" => "Missing notification_id"]);
        exit();
    }

    try {
        $stmt = $pdo->prepare("DELETE FROM notifications WHERE notification_id = ?");
        $stmt->execute([$notification_id]);

        echo json_encode(["status" => 200, "message" => "Notification deleted"]);
    } catch (PDOException $e) {
        echo json_encode(["status" => 500, "message" => "Database error: " . $e->getMessage()]);
    }
    exit();
}

// ✅ PUT METHOD — update notification status (mark as read/unread)
if ($method === 'PUT') {
    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data['notification_id']) || !isset($data['is_read'])) {
        echo json_encode(["status" => 400, "message" => "Missing notification_id or is_read"]);
        exit();
    }

    $notification_id = $data['notification_id'];
    $is_read = $data['is_read'];

    try {
        $stmt = $pdo->prepare("UPDATE notifications SET is_read = ? WHERE notification_id = ?");
        $stmt->execute([$is_read, $notification_id]);

        echo json_encode(["status" => 200, "message" => "Notification status updated"]);
    } catch (PDOException $e) {
        echo json_encode(["status" => 500, "message" => "Database error: " . $e->getMessage()]);
    }
    exit();
}

echo json_encode(["status" => 405, "message" => "Method not allowed"]);
exit();
?>
