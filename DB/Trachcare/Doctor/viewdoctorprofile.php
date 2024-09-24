<?php 
include "../config/conn.php";

// Received JSON into $json variable
$json = file_get_contents('php://input');

// Decoding the received JSON and storing it in $obj variable
$obj = json_decode($json, true);
if (!isset($_GET['doctor_id'])) {
    echo json_encode(["status" => false, "msg" => "Patient ID not provided"]);
    return;
}

$DoctorId = $_GET['doctor_id'];
$sql = "SELECT * FROM doctorprofile WHERE username = ?";
$stmt = $conn->prepare($sql);

if ($stmt === false) {
    die("Error preparing statement: " . $conn->error);
}

$stmt->bind_param("s", $DoctorId);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $data = $result->fetch_assoc();

    if ($data) {
        echo json_encode($data);
    } else {
        echo json_encode(["status" => false, "message" => "No patient found with this ID"]);
    }
} else {
    echo json_encode(["status" => false, "message" => $stmt->error]);
}

$stmt->close();
$conn->close();

GetPatientDetails($conn);


?>
