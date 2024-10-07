<?php 
include "../config/conn.php";

error_reporting(E_ALL);
ini_set('display_errors', 1);
 
function getDoctor($conn) {
    // Get the JSON input from the request body
    $json = file_get_contents('php://input');
    $obj = json_decode($json, true);
    $result = [];

    // Check if JSON was decoded successfully and if doctor_id is provided
    if ($obj === null || !isset($obj['doctor_id'])) {
        $result['Status'] = false;
        $result['message'] = "Doctor ID not provided or invalid JSON format.";
        echo json_encode($result);
        exit;
    }

    // Sanitize the input to prevent SQL injection
    $doctorId = mysqli_real_escape_string($conn, $obj['doctor_id']);

    // SQL query to fetch the doctor details
    $sql = "SELECT `doctor_id`, `username`, `doctor_reg_no`, `email`, `phone_number`, `password`, `image_path`, `created_at`
            FROM `doctorprofile` WHERE doctor_id='{$doctorId}'";

    // Execute the query
    $res = $conn->query($sql);

    if ($res->num_rows > 0) {
        $row = $res->fetch_assoc();
        $result['Status'] = true;
        $result['message'] = "Doctor information retrieved successfully.";
        $result["doctorInfo"] = $row; // Return the row as doctorInfo
    } else {
        $result['Status'] = false;
        $result['message'] = "Doctor ID not found.";
        $result['doctorInfo'] = null;
    }

    // Output the result as JSON
    echo json_encode($result);
}


?>
