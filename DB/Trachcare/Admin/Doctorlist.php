<?php
// Database connection
include "../config/conn.php"; // Assuming you have the connection stored in conn.php

// Array to store the response
$response = array();

try {
    // SQL query to fetch data
    $sql = "SELECT * FROM doctorprofile";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $data = array();

        // Fetch each row of data
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        // Set the response status to true and include the data
        $response['Status'] = true;
        $response['message'] = "Data fetched successfully.";
        $response['data'] = $data;
    } else {
        // If no data found, return an empty array with a success message
        $response['Status'] = true;
        $response['message'] = "No data found.";
        $response['data'] = [];
    }
} catch (Exception $e) {
    // Catch any errors and set the response status to false
    $response['Status'] = false;
    $response['message'] = "Error: " . $e->getMessage();
}

// Convert the response into JSON format
echo json_encode($response);

// Close the database connection
$conn->close();
?>
