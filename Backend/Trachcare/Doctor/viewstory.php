<?php
// Include your database connection file
require_once '../config/conn.php'; // Adjust the path as needed

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // Retrieve the doctor_id and date from the POST request
    $doctor_id = isset($_GET['doctor_id']) ? $_GET['doctor_id'] : '';
    $date = date('Y-m-d');
    // Validate inputs
    if (!empty($doctor_id) && !empty($date)) {
        // Prepare the SQL statement
        $stmt = $conn->prepare("SELECT * FROM `daily_report` WHERE `doctor_id` = ? AND `date` = ?");
        
        // Bind parameters
        $stmt->bind_param("ss", $doctor_id, $date);
        
        // Execute the statement
        $stmt->execute();
        
        // Get the result
        $result = $stmt->get_result();
        
        // Check if any records were found
        if ($result->num_rows > 0) {
            // Fetch all records as an associative array
            $reports = $result->fetch_all(MYSQLI_ASSOC);
            echo json_encode($reports); // Return data as JSON
        } else {
            echo json_encode([]); // No records found
        }

        // Close the statement
        $stmt->close();
    } else {
        echo json_encode(['error' => 'Doctor ID and Date are required']);
    }
} else {
    echo json_encode(['error' => 'Invalid request method']);
}

// Close the database connection
$conn->close();
?>
