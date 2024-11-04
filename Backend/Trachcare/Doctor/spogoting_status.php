<?php

include "../config/conn.php";

$response = array();

// Check if the request method is POST and required fields are set
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['patient_id']) && isset($_POST['cough_or_breathlessness'])&& isset($_POST['breath_duration'])) {
    
    $id = $_POST['patient_id'];
    $breath_duration = isset($_POST['breath_duration']) ? $_POST['breath_duration'] : NULL;
    $cough_or_breathlessness = isset($_POST['cough_or_breathlessness']) ? $_POST['cough_or_breathlessness'] : NULL;
    
    // Update query to update breath_duration and status in the database (time logic removed)
    $sql = "UPDATE spiotting_status SET cough_or_breathlessness = ?, breath_duration = ? WHERE patient_id = ?";
    
    // Prepare the SQL statement
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sss", $cough_or_breathlessness,$breath_duration, $id);

    // Execute the SQL statement
    if ($stmt->execute()) {
        $response['Status'] = true;
        $response['msg'] = "Status updated successfully";
    } else {
        $response['Status'] = false;
        $response['msg'] = "Error updating record: " . $conn->error;
    }

} else {
    $response['Status'] = false;
    $response['msg'] = "Invalid request method or missing parameters.";
}

// Return the response as JSON
echo json_encode($response);

?>
