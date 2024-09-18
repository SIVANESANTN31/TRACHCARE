<?php 
include "..\config\conn.php";

// Received JSON into $json variable
$json = file_get_contents('php://input');

// Decoding the received JSON and storing it in $obj variable
$obj = json_decode($json, true);

// Check if required fields are present in the request
if (isset($obj["date"]) && isset($obj["tablet_name"]) && isset($obj["patient_id"])) {

    // Escape variables for security
    $date = mysqli_real_escape_string($conn, $obj['date']);
    $tablet_name = mysqli_real_escape_string($conn, $obj['tablet_name']);
    $patient_id = mysqli_real_escape_string($conn, $obj['patient_id']);
    
    // Morning data
    $morning_before_food = isset($obj['morning_before_food']) ? (int)$obj['morning_before_food'] : 0;
    $morning_after_food = isset($obj['morning_after_food']) ? (int)$obj['morning_after_food'] : 0;
    
    // Afternoon data
    $afternoon_before_food = isset($obj['afternoon_before_food']) ? (int)$obj['afternoon_before_food'] : 0;
    $afternoon_after_food = isset($obj['afternoon_after_food']) ? (int)$obj['afternoon_after_food'] : 0;
    
    // Night data
    $night_before_food = isset($obj['night_before_food']) ? (int)$obj['night_before_food'] : 0;
    $night_after_food = isset($obj['night_after_food']) ? (int)$obj['night_after_food'] : 0;

    // Insert Query to add the medication details into the database
    $sql = "INSERT INTO medication_schedule 
            (patient_id, date, tablet_name, morning_before_food, morning_after_food, 
             afternoon_before_food, afternoon_after_food, 
             night_before_food, night_after_food)
            VALUES 
            ('$patient_id', '$date', '$tablet_name', '$morning_before_food', '$morning_after_food',
             '$afternoon_before_food', '$afternoon_after_food', 
             '$night_before_food', '$night_after_food')";

    if ($conn->query($sql) === TRUE) {
        $response['Status'] = true;
        $response['message'] = "Medication details added successfully.";
    } else {
        $response['Status'] = false;
        $response['message'] = "Error: " . $sql . "<br>" . $conn->error;
    }
} else {
    // If required fields are missing, set the Status to false and provide a message
    $response['Status'] = false;
    $response['message'] = "Required fields 'date', 'tablet_name', and 'patient_id' are missing.";
}

// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;

?>
