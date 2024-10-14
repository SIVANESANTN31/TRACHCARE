<?php

include "../config/conn.php";
$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['patient_id'])){
$id = $_GET['patient_id'];
// Set the default timezone to your desired timezone (optional)
date_default_timezone_set('Asia/Kolkata'); // Example: Asia/Kolkata for Indian time zone

// Get the current time in 12-hour format with AM/PM
$currentTime = date('h:i:s A');


// Define another time to compare with (e.g., 03:00:00 PM)
$compareTime_10 = '10:00:00 AM';
$compareTime_12 = '12:00:00 PM';
$compareTime_2 = '02:00:00 PM';
$stop_time ='03:00:00 PM';
// Display the current time
// echo "The current time is: " . $currentTime . "<br>";

// Compare the two times by converting them to timestamps
$currentTimeTimestamp = strtotime($currentTime);
$compareTimeTimestamp_10 = strtotime($compareTime_10);
$compareTimeTimestamp_12 = strtotime($compareTime_12);
$compareTimeTimestamp_2 = strtotime($compareTime_2);

// Perform the comparison
if ($currentTimeTimestamp > $compareTimeTimestamp_10 && $currentTimeTimestamp < $compareTime_12) {
    $sql = "SELECT doctorid,patient_id,stauts_10,issues FROM  daily_stauts WHERE patient_id = '$id'";
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

    
} elseif ($currentTimeTimestamp < $compareTimeTimestamp_2 && $currentTimeTimestamp > $compareTimeTimestamp_12) {
    $sql = "SELECT doctorid,patient_id,stauts_12,issues FROM  daily_stauts WHERE patient_id = '$id'";
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

   
} elseif ($currentTimeTimestamp < $stop_time && $currentTimeTimestamp > $compareTimeTimestamp_2) {
    $sql = "SELECT doctorid,patient_id,stauts_2,issues FROM  daily_stauts WHERE patient_id = '$id'";
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
    $sql = "SELECT *FROM  daily_stauts WHERE patient_id = '$id'";
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
}}
else {
    $response['Status'] = false;
    $response['msg'] = "Invalid request method.";
}


echo json_encode($response);
?>
