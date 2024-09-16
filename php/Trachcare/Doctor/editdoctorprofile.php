<?php 
include "../config/conn.php";

// Received JSON into $json variable
$json = file_get_contents('php://input');

// Decoding the received JSON and storing it in $obj variable
$obj = json_decode($json, true);

// Check if required fields are present in the request
if (isset($obj["username"])) {

    // Escape variables for security
    $username = mysqli_real_escape_string($conn, $obj['username']);
    $email = isset($obj['email']) ? mysqli_real_escape_string($conn, $obj['email']) : null;
    $phone_number = isset($obj['phone_number']) ? mysqli_real_escape_string($conn, $obj['phone_number']) : null;
    $password = isset($obj['password']) ? mysqli_real_escape_string($conn, $obj['password']) : null;
    $image_data = isset($obj['image_data']) ? $obj['image_data'] : null;

    // Check if the user exists
    $check_sql = "SELECT * FROM doctorprofile WHERE username = '$username'";
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
            $image_file = 'uploads/' . uniqid() . '.jpg';  // Save with a unique name
            file_put_contents($image_file, base64_decode($image_data));
            $update_fields[] = "image_path = '$image_file'";
        }

        // If there are fields to update
        if (!empty($update_fields)) {
            $update_sql = "UPDATE doctorprofile SET " . implode(', ', $update_fields) . " WHERE username = '$username'";

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

?>
