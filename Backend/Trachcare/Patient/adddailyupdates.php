<?php 
include "../config/conn.php";

// Check if required fields are present in the request
if (isset($_POST["patient_id"])) {

    // Escape variables for security
    $patient_id = mysqli_real_escape_string($conn, $_POST['patient_id']);
    
    $respiratory_rate = isset($_POST['respiratory_rate']) ? mysqli_real_escape_string($conn, $_POST['respiratory_rate']) : null;
    $heart_rate = isset($_POST['heart_rate']) ? mysqli_real_escape_string($conn, $_POST['heart_rate']) : null;
    $spo2_room_air = isset($_POST['spo2_room_air']) ? mysqli_real_escape_string($conn, $_POST['spo2_room_air']) : null;
    $daily_dressing_done = isset($_POST['daily_dressing_done']) ? mysqli_real_escape_string($conn, $_POST['daily_dressing_done']) : null;
    $tracheostomy_tie_changed = isset($_POST['tracheostomy_tie_changed']) ? mysqli_real_escape_string($conn, $_POST['tracheostomy_tie_changed']) : null;
    $suctioning_done = isset($_POST['suctioning_done']) ? mysqli_real_escape_string($conn, $_POST['suctioning_done']) : null;
    $oral_feeds_started = isset($_POST['oral_feeds_started']) ? mysqli_real_escape_string($conn, $_POST['oral_feeds_started']) : null;
    $changed_to_green_tube = isset($_POST['changed_to_green_tube']) ? mysqli_real_escape_string($conn, $_POST['changed_to_green_tube']) : null;
    $able_to_breathe_through_nose = isset($_POST['able_to_breathe_through_nose']) ? mysqli_real_escape_string($conn, $_POST['able_to_breathe_through_nose']) : null;
    $secretion_color_consistency = isset($_POST['secretion_color_consistency']) ? mysqli_real_escape_string($conn, $_POST['secretion_color_consistency']) : null;
    $cough_or_breathlessness = isset($_POST['cough_or_breathlessness']) ? mysqli_real_escape_string($conn, $_POST['cough_or_breathlessness']) : null;
    $breath_duration = isset($_POST['breath_duration']) ? mysqli_real_escape_string($conn, $_POST['breath_duration']) : null;
    $image_path = isset($_POST['image_path']) ? mysqli_real_escape_string($conn, $_POST['image_path']) : null;

    // Insert the new daily update into the daily_report table
    $insert_sql = "INSERT INTO daily_report (patient_id, respiratory_rate, heart_rate, spo2_room_air, daily_dressing_done, 
                    tracheostomy_tie_changed, suctioning_done, oral_feeds_started, changed_to_green_tube, 
                    able_to_breathe_through_nose, secretion_color_consistency, cough_or_breathlessness, breath_duration, image_path, created_at, updated_at) 
                    VALUES ('$patient_id','$respiratory_rate', '$heart_rate', '$spo2_room_air', '$daily_dressing_done', 
                    '$tracheostomy_tie_changed', '$suctioning_done', '$oral_feeds_started', '$changed_to_green_tube', 
                    '$able_to_breathe_through_nose', '$secretion_color_consistency', '$cough_or_breathlessness', '$breath_duration', '$image_path', NOW(), NOW())";

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
    $result['message'] = "Required field 'patient_id' is missing.";
}

// Convert the result array into JSON format
$json_data = json_encode($result);

// Echo the JSON data
echo $json_data;

?>
