<?php 
include "../config/conn.php"; // Include your database connection file

// Check if the form data is received via POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve form data
   
    $image_file = isset($_FILES['image_data']) ? $_FILES['image_data'] : null;

    // Validate required fields
    if ( $image_file) {
       
        // Validate the uploaded image
        $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
        $mimeType = $image_file['type'];

        if (!in_array($mimeType, $allowedTypes)) {
            echo json_encode(["status" => false, "msg" => "Unsupported image format."]);
            exit;
        }

        // Generate a unique filename
        $filenames = uniqid() . '.' . pathinfo($image_file['name'], PATHINFO_EXTENSION);
        $filePath = "../uploads/" . $filenames;

        // Move the uploaded file to the designated folder
        if (!move_uploaded_file($image_file['tmp_name'], $filePath)) {
            echo json_encode(["status" => false, "msg" => "Failed to save image."]);
            exit;
        }else{
            echo json_encode(["status" => true, "msg" => " save image.","msg"=>$filePath]);
            exit;
        }

        
    } else {
        $response['Status'] = false;
        $response['message'] = "Required fields are missing.";
    }
} else {
    $response['Status'] = false;
    $response['message'] = "Invalid request method.";
}

// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;

?>
