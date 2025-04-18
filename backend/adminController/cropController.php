<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include '../utility/object.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$method = $_SERVER['REQUEST_METHOD'];
$uploadDirectory = '../uploads/crops/';

if (!file_exists($uploadDirectory)) {
    mkdir($uploadDirectory, 0777, true);
}

function handleCropImageUpload($existingImage = null)
{
    global $uploadDirectory;

    if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
        $file = $_FILES['image'];

        $allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
        if (!in_array($file['type'], $allowedTypes)) {
            return ['error' => 'Only JPG, PNG, and GIF images are allowed'];
        }

        if ($file['size'] > 2 * 1024 * 1024) {
            return ['error' => 'Image size must be less than 2MB'];
        }

        $extension = pathinfo($file['name'], PATHINFO_EXTENSION);
        $filename = uniqid() . '.' . $extension;
        $destination = $uploadDirectory . $filename;

        if (move_uploaded_file($file['tmp_name'], $destination)) {
            if ($existingImage && file_exists($uploadDirectory . $existingImage)) {
                unlink($uploadDirectory . $existingImage);
            }
            return ['filename' => $filename];
        } else {
            return ['error' => 'Failed to upload image'];
        }
    }

    return ['filename' => $existingImage ?? null];
}

switch ($method) {
    case 'POST':
        $isMultipart = isset($_SERVER['CONTENT_TYPE']) && strpos($_SERVER['CONTENT_TYPE'], 'multipart/form-data') !== false;
        $inputData = $isMultipart ? $_POST : json_decode(file_get_contents("php://input"), true);
        $fileResult = $isMultipart ? handleCropImageUpload() : [];

        if (isset($fileResult['error'])) {
            echo json_encode(["status" => 400, "message" => $fileResult['error']]);
            exit();
        }

        // Common validation
        $requiredFields = ['name', 'variety', 'season', 'duration_days', 'region', 'soil_type', 'sowing_method', 'yield_kg_per_hectare'];
        foreach ($requiredFields as $field) {
            if (!isset($inputData[$field]) || empty(trim($inputData[$field]))) {
                echo json_encode(["status" => 400, "message" => ucfirst($field) . " is required"]);
                exit();
            }
        }

        $cropData = [
            'name' => trim($inputData['name']),
            'variety' => trim($inputData['variety']),
            'season' => trim($inputData['season']),
            'duration_days' => intval($inputData['duration_days']),
            'region' => trim($inputData['region']),
            'soil_type' => trim($inputData['soil_type']),
            'sowing_method' => trim($inputData['sowing_method']),
            'yield_kg_per_hectare' => intval($inputData['yield_kg_per_hectare']),
            'description' => $inputData['description'] ?? null,
            'updated_at' => date('Y-m-d H:i:s')
        ];

        if (!empty($fileResult['filename'])) {
            $cropData['image'] = $fileResult['filename'];
        }

        // 🚀 Check for ID → update instead of insert
        if (isset($inputData['id']) && is_numeric($inputData['id'])) {
            $id = intval($inputData['id']);

            // Get existing image for deletion if replaced
            $existing = $d->select('crops', "id = $id");
            $existingImage = null;
            if ($existing && mysqli_num_rows($existing) > 0) {
                $existingData = mysqli_fetch_assoc($existing);
                $existingImage = $existingData['image'] ?? null;
            }

            $cropData['updated_at'] = date('Y-m-d H:i:s');

            // Update
            $updated = $d->update('crops', $cropData, "id = $id");
            echo json_encode($updated ? [
                "status" => 200,
                "message" => "Crop updated successfully",
                "data" => $cropData
            ] : [
                "status" => 500,
                "message" => "Failed to update crop"
            ]);
        } else {
            // Insert
            $cropData['created_at'] = date('Y-m-d H:i:s');
            $inserted = $d->insert('crops', $cropData);

            echo json_encode($inserted ? [
                "status" => 200,
                "message" => "Crop added successfully",
                "data" => $cropData
            ] : [
                "status" => 500,
                "message" => "Failed to add crop"
            ]);
        }
        exit();

    case 'GET':
        $result = $d->select('crops');
        $crops = [];

        while ($row = mysqli_fetch_assoc($result)) {
            $crops[] = $row;
        }

        echo json_encode([
            "status" => 200,
            "message" => "Crops retrieved successfully",
            "data" => $crops
        ]);
        exit();

    case 'DELETE':
        if (!isset($_GET['id'])) {
            echo json_encode(["status" => 400, "message" => "Crop ID is required"]);
            exit();
        }

        $id = intval($_GET['id']);
        $crop = $d->select('crops', "id = $id");

        if ($crop && mysqli_num_rows($crop) > 0) {
            $cropData = mysqli_fetch_assoc($crop);
            if (!empty($cropData['image']) && file_exists($uploadDirectory . $cropData['image'])) {
                unlink($uploadDirectory . $cropData['image']);
            }
        }

        $deleteStatus = $d->delete('crops', "id = $id");

        echo json_encode($deleteStatus ? [
            "status" => 200,
            "message" => "Crop deleted successfully"
        ] : [
            "status" => 500,
            "message" => "Crop deletion failed"
        ]);
        exit();
}
