<?php 
include "..\config\conn.php";

// Received JSON into $json variable
$json = file_get_contents('php://input');

// Decoding the received JSON and storing it in $obj variable
$obj = json_decode($json, true);

// Check if required fields are present in the request
if (isset($obj["name"]) && isset($obj["date"])) {

    // Escape variables for security
    $name = mysqli_real_escape_string($conn, $obj['name']);
    $date = mysqli_real_escape_string($conn, $obj['date']);
    $respiratory_rate = isset($obj['respiratory_rate']) ? mysqli_real_escape_string($conn, $obj['respiratory_rate']) : null;
    $heart_rate = isset($obj['heart_rate']) ? mysqli_real_escape_string($conn, $obj['heart_rate']) : null;
    $spo2_room_air = isset($obj['spo2_room_air']) ? mysqli_real_escape_string($conn, $obj['spo2_room_air']) : null;
    $daily_dressing_done = isset($obj['daily_dressing_done']) ? mysqli_real_escape_string($conn, $obj['daily_dressing_done']) : null;
    $tracheostomy_tie_changed = isset($obj['tracheostomy_tie_changed']) ? mysqli_real_escape_string($conn, $obj['tracheostomy_tie_changed']) : null;
    $suctioning_done = isset($obj['suctioning_done']) ? mysqli_real_escape_string($conn, $obj['suctioning_done']) : null;
    $oral_feeds_started = isset($obj['oral_feeds_started']) ? mysqli_real_escape_string($conn, $obj['oral_feeds_started']) : null;
    $changed_to_green_tube = isset($obj['changed_to_green_tube']) ? mysqli_real_escape_string($conn, $obj['changed_to_green_tube']) : null;
    $able_to_breathe_through_nose = isset($obj['able_to_breathe_through_nose']) ? mysqli_real_escape_string($conn, $obj['able_to_breathe_through_nose']) : null;
    $secretion_color_consistency = isset($obj['secretion_color_consistency']) ? mysqli_real_escape_string($conn, $obj['secretion_color_consistency']) : null;
    $cough_or_breathlessness = isset($obj['cough_or_breathlessness']) ? mysqli_real_escape_string($conn, $obj['cough_or_breathlessness']) : null;
    $breath_duration = isset($obj['breath_duration']) ? mysqli_real_escape_string($conn, $obj['breath_duration']) : null;
    $image_path = isset($obj['image_path']) ? mysqli_real_escape_string($conn, $obj['image_path']) : null;

    // Insert the new daily update into the Patientsdetails table
    $insert_sql = "INSERT INTO daily_report (name, date, respiratory_rate, heart_rate, spo2_room_air, daily_dressing_done, 
                    tracheostomy_tie_changed, suctioning_done, oral_feeds_started, changed_to_green_tube, 
                    able_to_breathe_through_nose, secretion_color_consistency, cough_or_breathlessness, breath_duration, image_path) 
                    VALUES ('$name', '$date', '$respiratory_rate', '$heart_rate', '$spo2_room_air', '$daily_dressing_done', 
                    '$tracheostomy_tie_changed', '$suctioning_done', '$oral_feeds_started', '$changed_to_green_tube', 
                    '$able_to_breathe_through_nose', '$secretion_color_consistency', '$cough_or_breathlessness', '$breath_duration', '$image_path')";

    if ($conn->query($insert_sql) === TRUE) {
        $result['Status'] = true;
        $result['message'] = "Patient daily updates added successfully.";
    } else {
        $result['Status'] = false;
        $result['message'] = "Error adding daily updates: " . $conn->error;
    }
} else {
    // If required fields are missing, set the Status to false and provide a message
    $result['Status'] = false;
    $result['message'] = "Required fields 'name' and 'date' are missing.";
}

// Convert the result array into JSON format
$json_data = json_encode($result);

// Echo the JSON data
echo $json_data;

?>
