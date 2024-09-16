<?php
include "../config/conn.php";

// Received JSON into $json variable
$json = file_get_contents('php://input');

// Decoding the received JSON and storing it in $obj variable
$obj = json_decode($json, true);

// Check if required fields are present in the request
if (isset($obj["patient_id"]) && isset($obj["date"]) && isset($obj["tablet_name"])) {

    // Escape variables for security
    $patient_id = mysqli_real_escape_string($conn, $obj['patient_id']);
    $date = mysqli_real_escape_string($conn, $obj['date']);
    $tablet_name = mysqli_real_escape_string($conn, $obj['tablet_name']);
    
    // Morning data
    $morning_before_food = isset($obj['morning_before_food']) ? (int)$obj['morning_before_food'] : 0;
    $morning_after_food = isset($obj['morning_after_food']) ? (int)$obj['morning_after_food'] : 0;
    
    // Afternoon data
    $afternoon_before_food = isset($obj['afternoon_before_food']) ? (int)$obj['afternoon_before_food'] : 0;
    $afternoon_after_food = isset($obj['afternoon_after_food']) ? (int)$obj['afternoon_after_food'] : 0;
    
    // Night data
    $night_before_food = isset($obj['night_before_food']) ? (int)$obj['night_before_food'] : 0;
    $night_after_food = isset($obj['night_after_food']) ? (int)$obj['night_after_food'] : 0;

    // Update Query to edit the medication details in the database
    $sql = "UPDATE medication_schedule 
            SET morning_before_food = '$morning_before_food',
                morning_after_food = '$morning_after_food',
                afternoon_before_food = '$afternoon_before_food',
                afternoon_after_food = '$afternoon_after_food',
                night_before_food = '$night_before_food',
                night_after_food = '$night_after_food'
            WHERE patient_id = '$patient_id' AND date = '$date' AND tablet_name = '$tablet_name'";

    if ($conn->query($sql) === TRUE) {
        if ($conn->affected_rows > 0) {
            $response['Status'] = true;
            $response['message'] = "Medication details updated successfully.";
        } else {
            $response['Status'] = false;
            $response['message'] = "No records updated. Please check the patient_id, date, or tablet_name.";
        }
    } else {
        $response['Status'] = false;
        $response['message'] = "Error: " . $sql . "<br>" . $conn->error;
    }
} else {
    // If required fields are missing, set the Status to false and provide a message
    $response['Status'] = false;
    $response['message'] = "Required fields 'patient_id', 'date', and 'tablet_name' are missing.";
}

// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;

?>
