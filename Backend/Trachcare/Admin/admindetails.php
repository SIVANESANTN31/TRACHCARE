<?php

include '../config/conn.php';
getDoctor($conn, $_GET['doctor_id']);

function getDoctor($conn, $id) {
    $id = mysqli_real_escape_string($conn, $id);
    $result = [];

    $sql = "SELECT * FROM adminlogin WHERE doctor_id='{$id}'";
    $res = $conn->query($sql);

    if ($res->num_rows > 0) {
        $row = $res->fetch_assoc();
        $result['Status'] = true;
        $result['message'] = "Successfully retrieved the id from the database.";
        $result["doctorInfo"] = $row;
    } else {
        $result['Status'] = false;
        $result['message'] = "Failed to retrieve the id from the database.";
        $result['doctorInfo'] = "Failed to retrieve the id from the database.";
    }

    echo json_encode($result);
}
?>