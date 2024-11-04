<?php

include "../config/conn.php";
$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['doctorid'])){
$id = $_GET['doctorid'];

    $sql = "SELECT *FROM  daily_stauts WHERE doctorid = '$id'AND issues!=0";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $data = array();

        // Fetch each row of data
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        // Set the response status to true and include the data
        $response['Status'] = true;
        $response['message'] = "Data fetched successfully.";
        $response['data'] = $data;
    } else {
        // If no data found, return an empty array with a success message
        $response['Status'] = true;
        $response['message'] = "No data found.";
        $response['data'] = [];
    }
}
else {
    $response['Status'] = false;
    $response['msg'] = "Invalid request method.";
}


echo json_encode($response);
?>
