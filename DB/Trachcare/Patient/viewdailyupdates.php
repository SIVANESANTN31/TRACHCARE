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

    // Query to select the details of the patient for the given date
    $select_sql = "SELECT * FROM daily_report WHERE name = '$name' AND DATE(created_at) = '$date'";
    $result = $conn->query($select_sql);

    if ($result->num_rows > 0) {
        // Fetch the data and prepare it for JSON output
        $row = $result->fetch_assoc();
        $output['Status'] = true;
        $output['data'] = $row;
    } else {
        // If no record exists, return an error
        $output['Status'] = false;
        $output['message'] = "No record found for the given patient and date.";
    }
} else {
    // If required fields are missing, set the Status to false and provide a message
    $output['Status'] = false;
    $output['message'] = "Required fields 'name' and 'date' are missing.";
}

// Convert the result array into JSON format
$json_data = json_encode($output);

// Echo the JSON data
echo $json_data;

?>
