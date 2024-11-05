<?php 
include "../config/conn.php";

// Check if the patient_id and date are provided in POST data
if (isset($_POST["patient_id"]) && isset($_POST["date"])) {
    // Escape the input for security
    $patient_id = mysqli_real_escape_string($conn, $_POST['patient_id']);
    $date = mysqli_real_escape_string($conn, $_POST['date']);
    
    // Validate date format (optional, can be adjusted as needed)
    if (DateTime::createFromFormat('Y-m-d', $date) === false) {
        $response['Status'] = false;
        $response['message'] = "Invalid date format. Please use 'YYYY-MM-DD'.";
        echo json_encode($response);
        exit;
    }

    // SQL query to fetch daily reports for the given patient_id and date
    $query = "SELECT * FROM daily_report WHERE patient_id = '$patient_id' AND DATE(created_at) = '$date' ORDER BY created_at DESC";
    
    $result = $conn->query($query);
    
    // Initialize an array to hold the data
    $daily_reports = [];

    if ($result->num_rows > 0) {
        // Fetch all daily reports
        while ($row = $result->fetch_assoc()) {
            $daily_reports[] = $row;
        }
        // Set the response status and message
        $response['Status'] = true;
        $response['message'] = "Daily reports retrieved successfully.";
        $response['data'] = $daily_reports; // Add the fetched data
    } else {
        // If no reports are found for the given date
        $response['Status'] = false;
        $response['message'] = "No daily reports found for the given patient ID on the specified date.";
    }
} else {
    // If required fields are missing
    $response['Status'] = false;
    $response['message'] = "Required fields 'patient_id' and 'date' are missing.";
}

// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;
?>
