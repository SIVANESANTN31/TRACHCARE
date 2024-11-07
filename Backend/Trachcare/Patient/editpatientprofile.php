<?php 
include "../config/conn.php";

// Check if required fields are present in the request
if (isset($_POST["patient_id"])) {

    // Escape variables for security
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $email = isset($_POST['email']) ? mysqli_real_escape_string($conn, $_POST['email']) : null;
    $phone_number = isset($_POST['phone_number']) ? mysqli_real_escape_string($conn, $_POST['phone_number']) : null;
    $password = isset($_POST['password']) ? mysqli_real_escape_string($conn, $_POST['password']) : null;
    $patient_id = isset($_POST['patient_id']) ? mysqli_real_escape_string($conn, $_POST['patient_id']) : null;
    $image_data = isset($_FILES['image']['name']) ? uploadImage($_FILES['image']) : "siva";

    // Check if the user exists
    $check_sql = "SELECT * FROM patientprofile WHERE patient_id = '$patient_id'";
    $check_result = $conn->query($check_sql);

    if ($check_result->num_rows > 0) {
        // Prepare the update query
        $update_fields = [];

        if ($email !== null) {
            $update_fields[] = "email = '$email'";
        }
        if ($phone_number !== null) {
            $update_fields[] = "phone_number = '$phone_number'";
        }
        if ($password !== null) {
            $update_fields[] = "password = '$password'";
        }
        if ($image_data !== null) {
            // Decode base64 image data and save the file
            $image_file = '../uploads/patient_images/' . uniqid() . '.jpg';  // Save with a unique name
            // file_put_contents($image_file, base64_decode($image_data));
            $update_fields[] = "image_path = '$image_file'";
        }

        // If there are fields to update
        if (!empty($update_fields)) {
            $update_sql = "UPDATE patientprofile SET " . implode(', ', $update_fields) . " WHERE patient_id = '$patient_id'";

            if ($conn->query($update_sql) === TRUE) {
                $response['Status'] = true;
                $response['message'] = "User details updated successfully.";
            } else {
                $response['Status'] = false;
                $response['message'] = "Error updating record: " . $conn->error;
            }
        } else {
            $response['Status'] = false;
            $response['message'] = "No fields to update.";
        }
    } else {
        // If no record is found
        $response = [
            'Status' => false,
            'message' => "No user found with the provided username."
        ];
    }
} else {
    // If required fields are missing, set the Status to false and provide a message
    $response['Status'] = false;
    $response['message'] = "Required field 'username' is missing.";
}

// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;


function uploadImage($file) {
    $target_dir = "../uploads/patient_images/";
    $target_file = $target_dir . basename($file["name"]);
    $uploadOk = 1;
    $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

    // Check if image file is an actual image or fake image
    $check = getimagesize($file["tmp_name"]);
    if ($check === false) {
        $uploadOk = 0;
    }

    // Check file size
    if ($file["size"] > 500000) { // 500 KB limit
        $uploadOk = 0;
    }

    // Allow certain file formats
    if ($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif") {
        $uploadOk = 0;
    }

    // Check if $uploadOk is set to 0 by an error
    if ($uploadOk == 0) {
        return null; // Return null if upload fails
    } else {
        if (move_uploaded_file($file["tmp_name"], $target_file)) {
            return $target_file; // Return the file path on success
        } else {
            return null;
        }
    }
}


?>
