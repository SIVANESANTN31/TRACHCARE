<?php

include '../config/conn.php';

function GetPatientDetails($conn) {
    if (!isset($_GET['patient_id'])) {
        echo json_encode(["status" => false, "msg" => "Patient ID not provided"]);
        return;
    }

    $patientId = $_GET['patient_id'];
    $sql = "SELECT * FROM addpatients WHERE patient_id = ?";
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        die("Error preparing statement: " . $conn->error);
    }

    $stmt->bind_param("s", $patientId);

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
}

GetPatientDetails($conn);

?>
