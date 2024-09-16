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
    
    // Select Query to retrieve the medication details from the database
    $sql = "SELECT patient_id, date, tablet_name, morning_before_food, morning_after_food, 
                    afternoon_before_food, afternoon_after_food, 
                    night_before_food, night_after_food
            FROM medication_schedule 
            WHERE patient_id = '$patient_id' AND date = '$date' AND tablet_name = '$tablet_name'";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Fetch the data and prepare the response
        $medication_details = $result->fetch_assoc();
        $response['Status'] = true;
        $response['data'] = $medication_details;
    } else {
        // If no record found
        $response['Status'] = false;
        $response['message'] = "No records found for the given patient_id, date, or tablet_name.";
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
