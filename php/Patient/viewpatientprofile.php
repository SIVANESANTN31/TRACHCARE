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

    // Select Query to fetch user details based on the username
    $sql = "SELECT username, email, phone_number, password, image_path FROM patientprofile WHERE username = '$username'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Fetch the user details
        $row = mysqli_fetch_assoc($result);

        // Get the image data and encode it as base64
        $image_data = null;
        if (!empty($row['image_path']) && file_exists($row['image_path'])) {
            $image_data = base64_encode(file_get_contents($row['image_path']));
        }

        // Prepare the result array
        $response = [
            'Status' => true,
            'message' => "User details retrieved successfully.",
            'data' => [
                'username' => $row['username'],
                'email' => $row['email'],
                'phone_number' => $row['phone_number'],
                'password' => $row['password'],
                'image_data' => $image_data // Include the base64-encoded image data
            ]
        ];
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
