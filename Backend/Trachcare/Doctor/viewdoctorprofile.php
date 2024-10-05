<?php 
include "../config/conn.php";

// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$response = []; // Initialize the response array

if (!isset($_GET['doctor_id'])) {
    $response = ["status" => false, "msg" => "Doctor ID not provided"];
    echo json_encode($response);
    return;
}

$DoctorId = $_GET['doctor_id'];
$sql = "SELECT * FROM doctorprofile WHERE doctor_id = ?";
$stmt = $conn->prepare($sql);

if ($stmt === false) {
    $response = ["status" => false, "message" => "Error preparing statement: " . $conn->error];
    echo json_encode($response);
    return; // Exit the script
}

$stmt->bind_param("s", $DoctorId);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $data = $result->fetch_assoc();
    
    if ($data) {
        $response = ["status" => true, "message" => "Admin details fetched successfully", "data" => $data];
    } else {
        $response = ["status" => false, "message" => "No doctor found with this ID"];
    }
} else {
    $response = ["status" => false, "message" => $stmt->error];
}

$stmt->close();
$conn->close();

// If you have a GetPatientDetails function, call it here (make sure it's defined)
if (function_exists('GetPatientDetails')) {
    GetPatientDetails($conn);
}

echo json_encode($response); // Output the response as JSON
?>
