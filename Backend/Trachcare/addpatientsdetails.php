<?php 
include "config/conn.php";

// Received JSON into $json variable
$json = file_get_contents('php://input');

// Decoding the received JSON and storing it in $obj variable
$obj = json_decode($json, true);

// Check if required fields are present in the request
if(isset($obj["username"], $obj["email"], $obj["phone_number"], $obj["password"], $obj["doctor_reg_no"], )) {

    // Escape variables for security
    $username = mysqli_real_escape_string($conn, $obj['username']);
    $email = mysqli_real_escape_string($conn, $obj['email']);
    $phone_number = mysqli_real_escape_string($conn, $obj['phone_number']);
    $password = mysqli_real_escape_string($conn, $obj['password']);
    $image_data = isset($obj['image_data']) ? $obj['image_data'] : null;

    // Handle image upload if provided
    $image_file = null;
    if ($image_data !== null) {
        $image_file = 'uploads/' . uniqid() . '.jpg';  // Save with a unique name
        file_put_contents($image_file, base64_decode($image_data));
        $insert_sql = "INSERT INTO patientprofile (username, email, phone_number, password, image_path) 
                   VALUES ('$username', '$email', '$phone_number', '$password', '$image_file')";
    }
    // Prepare the insert query
    else{
        $insert_sql = "INSERT INTO patientprofile (username, email, phone_number, password) 
                   VALUES ('$username', '$email', '$phone_number', '$password')";
    }
    // Execute the query
    if ($conn->query($insert_sql) === TRUE) {
        $response['Status'] = true;
        $response['message'] = "New user created successfully.";
    } else {
        $response['Status'] = false;
        $response['message'] = "Error: " . $insert_sql . "<br>" . $conn->error;
    }

} else {
    // If required fields are missing, set the Status to false and provide a message
    $response['Status'] = false;
    $response['message'] = "Required fields are missing.";
}

// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;

?>
