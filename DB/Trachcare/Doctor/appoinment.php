<?php
include "../config/conn.php";


$method = $_SERVER['REQUEST_METHOD'];

if($method=="POST"){
    addAppointment($conn);
 }
 elseif($method=="PUT"){
    addAppointmentput($conn);
 }
 elseif($method=="GET"){
    getAppointment($conn);
 }
 else{
    echo "Method not supported";
 }







function addAppointment($conn) {
    // Get JSON input from the request body
    $json = file_get_contents('php://input');

    // Decode JSON into an associative array
    $obj = json_decode($json, true);
    $result = [];

    // Check if JSON is decoded successfully
    if ($obj === null) {
        echo json_encode(["status" => false, "msg" => "Invalid JSON data."]);
        exit;
    }
    $doctorid = $obj['doctorid'];
    $patient_id = $obj['patientid'];
    $date = $obj['date'];

    $sql = "INSERT INTO appoinment_table (doctorid, patient_id, date) VALUES (?, ?, ?)";

    // Prepare the SQL statement
    $stmt = $conn->prepare($sql);

    if ($stmt) {
        // Bind the parameters to the SQL query
        $stmt->bind_param("sss", $doctorid, $patient_id, $date);

        // Execute the prepared statement
        if ($stmt->execute()) {
            $result['status'] = true;
            $result ['msg'] = "New appointment added successfully.";
            echo json_encode($result);
        } else {
            echo "Error: " . $stmt->error;
        }

        // Close the prepared statement
        $stmt->close();
    } else {
        echo "Error: " . $conn->error;
    }

    // Close the database connection
    $conn->close();
}



function addAppointmentput($conn) {
    
    $json = file_get_contents('php://input');

    // Decode JSON into an associative array
    $obj = json_decode($json, true);
    $result = [];

    // Check if JSON is decoded successfully
    if ($obj === null) {
        echo json_encode(["status" => false, "msg" => "Invalid JSON data."]);
        exit;
    }

    // Extract values from the associative array
    $doctorid = $obj['doctorid'] ?? '';
    $patient_id = $obj['patientid'] ?? '';
    $date = $obj['date'] ?? '';

    // Validate input values (basic validation)
    if (empty($doctorid) || empty($patient_id) || empty($date)) {
        echo json_encode(["status" => false, "msg" => "Missing required fields."]);
        exit;
    }

    // SQL query to insert values into the table
    $sql = "UPDATE appoinment_table SET date = ? WHERE doctorid = ? AND patient_id=?";

    // Prepare the SQL statement
    $stmt = $conn->prepare($sql);

    if ($stmt) {
        // Bind the parameters to the SQL query
        $stmt->bind_param("sss",$date,$doctorid, $patient_id);

        // Execute the prepared statement
        if ($stmt->execute()) {
            $result['status'] = true;
            $result['msg'] = " appointment Updated successfully.";
            echo json_encode($result);
        } else {
            echo json_encode(["status" => false, "msg" => "Error executing query: " . $stmt->error]);
        }

        // Close the prepared statement
        $stmt->close();
    } else {
        echo json_encode(["status" => false, "msg" => "Error preparing statement: " . $conn->error]);
    }

    // Close the database connection
    $conn->close();
}



function getAppointment($conn) {
    // Check if the request method is GET
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        echo json_encode(["status" => false, "msg" => "Invalid request method. Only GET is allowed."]);
        exit;
    }

    // Check if both patient_id and doctorid are provided in the query parameters
    if (!isset($_GET['patientid']) || !isset($_GET['doctorid'])) {
        echo json_encode(["status" => false, "msg" => "Missing required parameters."]);
        exit;
    }

    $patientId = $_GET['patientid'];
    $doctorId = $_GET['doctorid'];

    // Prepare the SQL query to fetch appointments
    $sql = "SELECT * FROM appoinment_table WHERE patient_id = ? AND doctorid = ?";

    // Prepare the SQL statement
    $stmt = $conn->prepare($sql);

    if ($stmt) {
        // Bind the parameters to the SQL query
        $stmt->bind_param("ss", $patientId, $doctorId);

        // Execute the prepared statement
        $stmt->execute();

        // Get the result
        $result = $stmt->get_result();

        // Fetch all rows as an associative array
        $appointments = $result->fetch_all(MYSQLI_ASSOC);

        if ($appointments) {
            echo json_encode(["status" => true, "data" => $appointments]);
        } else {
            echo json_encode(["status" => false, "msg" => "No appointments found for the given patient ID and doctor ID."]);
        }

        // Close the statement
        $stmt->close();
    } else {
        echo json_encode(["status" => false, "msg" => "Error preparing statement: " . $conn->error]);
    }

    // Close the database connection
    $conn->close();
}







?>


