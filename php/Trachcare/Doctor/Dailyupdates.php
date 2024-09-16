<?php 
include "../config/conn.php";  // Include the database connection file

$method = $_SERVER['REQUEST_METHOD'];

if ($method =='POST'){
    AddandDailyUpdates($conn);
}
elseif ($method =='GET'){
    GetPatientsdetials($conn);

}


function AddandDailyUpdates($conn){
    // Received JSON into $json variable
$json = file_get_contents('php://input');

// Decoding the received JSON and storing it in $obj variable
$obj = json_decode($json, true);

// Initialize the result array
$result = [];

// Check if required fields 'patient_id' and 'date' are present in the request
if (isset($obj["patient_id"]) && isset($obj["date"])) {

    // Escape variables for security against SQL injection
    $patient_id = mysqli_real_escape_string($conn, $obj['patient_id']);
    $date = mysqli_real_escape_string($conn, $obj['date']);
    $respiratory_rate = mysqli_real_escape_string($conn, $obj['respiratory_rate']);
    $heart_rate = mysqli_real_escape_string($conn, $obj['heart_rate']);
    $spo2_room_air = mysqli_real_escape_string($conn, $obj['spo2_room_air']);
    $daily_dressing_done = isset($obj['daily_dressing_done']) ? mysqli_real_escape_string($conn, $obj['daily_dressing_done']) : 'No';
    $tracheostomy_tie_changed = isset($obj['tracheostomy_tie_changed']) ? mysqli_real_escape_string($conn, $obj['tracheostomy_tie_changed']) : 'No';
    $suctioning_done = isset($obj['suctioning_done']) ? mysqli_real_escape_string($conn, $obj['suctioning_done']) : 'No';
    $oral_feeds_started = isset($obj['oral_feeds_started']) ? mysqli_real_escape_string($conn, $obj['oral_feeds_started']) : 'No';
    $changed_to_green_tube = isset($obj['changed_to_green_tube']) ? mysqli_real_escape_string($conn, $obj['changed_to_green_tube']) : 'No';
    $able_to_breathe_through_nose = isset($obj['able_to_breathe_through_nose']) ? mysqli_real_escape_string($conn, $obj['able_to_breathe_through_nose']) : 'No';
    $secretion_color_consistency = mysqli_real_escape_string($conn, $obj['secretion_color_consistency']);
    $cough_or_breathlessness = isset($obj['cough_or_breathlessness']) ? mysqli_real_escape_string($conn, $obj['cough_or_breathlessness']) : 'No';
    $breath_duration = isset($obj['breath_duration']) ? mysqli_real_escape_string($conn, $obj['breath_duration']) : null;
    $image_path = mysqli_real_escape_string($conn, $obj['image_path']);

    // Check if a record already exists for this patient on the given date
    $check_sql = "SELECT * FROM daily_report  WHERE patient_id = '$patient_id' AND DATE(date) = '$date'";
    $check_result = $conn->query($check_sql);

    if ($check_result->num_rows > 0) {
        // If a record exists, update it
        $update_sql = "UPDATE daily_report  SET 
                        respiratory_rate = '$respiratory_rate',
                        heart_rate = '$heart_rate',
                        spo2_room_air = '$spo2_room_air',
                        daily_dressing_done = '$daily_dressing_done',
                        tracheostomy_tie_changed = '$tracheostomy_tie_changed',
                        suctioning_done = '$suctioning_done',
                        oral_feeds_started = '$oral_feeds_started',
                        changed_to_green_tube = '$changed_to_green_tube',
                        able_to_breathe_through_nose = '$able_to_breathe_through_nose',
                        secretion_color_consistency = '$secretion_color_consistency',
                        cough_or_breathlessness = '$cough_or_breathlessness',
                        breath_duration = '$breath_duration',
                        image_path = '$image_path'
                      WHERE patient_id = '$patient_id' AND DATE(date) = '$date'";

        if ($conn->query($update_sql) === TRUE) {
            $result['Status'] = true;
            $result['message'] = "Patient details updated successfully.";
        } else {
            $result['Status'] = false;
            $result['message'] = "Error updating record: " . $conn->error;
        }
    } else {
        // If no record exists, insert a new one
        $insert_sql = "INSERT INTO daily_report(
                        patient_id, 
                        date,
                        respiratory_rate, 
                        heart_rate, 
                        spo2_room_air, 
                        daily_dressing_done, 
                        tracheostomy_tie_changed, 
                        suctioning_done, 
                        oral_feeds_started, 
                        changed_to_green_tube, 
                        able_to_breathe_through_nose, 
                        secretion_color_consistency, 
                        cough_or_breathlessness, 
                        breath_duration, 
                        image_path
                      ) VALUES (
                        '$patient_id', 
                        '$date', 
                        '$respiratory_rate', 
                        '$heart_rate', 
                        '$spo2_room_air', 
                        '$daily_dressing_done', 
                        '$tracheostomy_tie_changed', 
                        '$suctioning_done', 
                        '$oral_feeds_started', 
                        '$changed_to_green_tube', 
                        '$able_to_breathe_through_nose', 
                        '$secretion_color_consistency', 
                        '$cough_or_breathlessness', 
                        '$breath_duration', 
                        '$image_path'
                      )";

        if ($conn->query($insert_sql) === TRUE) {
            $result['Status'] = true;
            $result['message'] = "Patient details added successfully.";
        } else {
            $result['Status'] = false;
            $result['message'] = "Error inserting record: " . $conn->error;
        }
    }
} else {
    // If required fields are missing, set the Status to false and provide a message
    $result['Status'] = false;
    $result['message'] = "Required fields 'patient_id' and 'date' are missing.";
}

// Convert the result array into JSON format
$json_data = json_encode($result);

// Echo the JSON data
echo $json_data;

}

function GetPatientsdetials($conn){

    $response = array();

// Check if the required parameters are provided
if (isset($_GET["patient_id"]) && isset($_GET["date"])) {
    $patient_id = mysqli_real_escape_string($conn, $_GET['patient_id']);
    $date = mysqli_real_escape_string($conn, $_GET['date']);

    // Define the SQL query to retrieve data from the patient_details table for the specific patient and date
    $sql = "SELECT * FROM daily_report WHERE patient_id = '$patient_id' AND DATE = '$date'";

    // Execute the query
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Fetch the record and store it in the response array
        $response['Status'] = true;
        $response['patient_details'] = array();

        while($row = $result->fetch_assoc()) {
            $response['patient_details'][] = $row;
        }
    } else {
        // If no records are found, set the Status to false and provide a message
        $response['Status'] = false;
        $response['message'] = "No patient records found for the given date.";
    }
} else {
    // If required parameters are missing, set the Status to false and provide a message
    $response['Status'] = false;
    $response['message'] = "Required parameters 'name' and 'date' are missing.";
}

// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;


}



?>
