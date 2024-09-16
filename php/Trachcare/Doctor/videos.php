<?php
 include "../config/conn.php";

 $method = $_SERVER['REQUEST_METHOD'];

if($method=="POST"){
 uploadvideos($conn);
 }
 elseif($method=="GET"){
    fetchVideoDetails($conn);


 }


function uploadvideos($conn){

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Define the directory where videos will be stored
        $uploadDir = '../uploads/videos/';
        $result = [];
        // Get the uploaded file information
        $videoFile = $_FILES['videoFile'];
        $videoName = basename($videoFile['name']);
        $id= rand(100, 100000);
        $uploadFilePath = $uploadDir . (string)$id . $videoName ;

        $patient_id = $_POST['patient_id'];
        $doctorid = $_POST['doctorid'];
    
        // Validate the file type
        $allowedTypes = ['video/mp4', 'video/avi', 'video/mov', 'video/mkv'];
        $fileType = mime_content_type($videoFile['tmp_name']);
        
        if (!in_array($fileType, $allowedTypes)) {
            echo json_encode(["status" => false, "msg" => "Invalid video format. Only MP4, AVI, MOV, and MKV are allowed."]);
            exit;
        }
    
        // Check if the file is a valid video
        if (move_uploaded_file($videoFile['tmp_name'], $uploadFilePath)) {

            $sql = "UPDATE patientvideotable 
            SET Video_url = CONCAT(IFNULL(Video_url, ''), ?) 
            WHERE doctorid = ? AND patient_id = ?";

    // Prepare the statement
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        die("Error preparing statement: " . $conn->error);
    }

    // Bind parameters to the SQL statement
    $uploadFilePath = str_replace('..', '/n', $uploadFilePath); // Remove path for storage
    $stmt->bind_param("sss", $uploadFilePath, $doctorid, $patient_id);

    // Execute the statement
    if ($stmt->execute()) {
        $result['Status'] = true;
        $result['message'] = "Video uploaded successfully.";
    } else {
        $result['Status'] = false;
        $result['message'] = "Error updating video details: " . $stmt->error;
    }

    // Close the statement
    $stmt->close();
            // Success: Return JSON response
            echo json_encode($result);
        } else {
            // Failure: Return JSON response
            echo json_encode(["status" => false, "msg" => "Failed to upload video."]);
        }
    } else {
        echo json_encode(["status" => false, "msg" => "Invalid request method."]);
    }

}


function fetchVideoDetails($conn) {


    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        echo json_encode(["status" => false, "msg" => "Invalid request method. Only GET is allowed."]);
        exit;
    }

 
        if (isset($_GET['patient_id']) || isset($_GET['doctorid'])) {
            $patient_id = $_GET['patient_id'];
            $doctorid = $_GET['doctorid'];

            // Prepare the SQL query to fetch video details
            $sql = "SELECT  Video_url FROM patientvideotable WHERE patient_id = ? AND doctorid = ?";
            
            // Prepare the statement
            $stmt = $conn->prepare($sql);

            if ($stmt === false) {
                die("Error preparing statement: " . $conn->error);
            }

            // Bind the 'patient_id' parameter to the SQL statement
            $stmt->bind_param("ss", $patient_id,$doctorid);

            // Execute the statement
            if ($stmt->execute()) {
                // Fetch the result
                $result = $stmt->get_result();
                
                if ($result->num_rows > 0) {
                    // Fetch all the rows as an associative array
                    $videoDetails = $result->fetch_all(MYSQLI_ASSOC);
                    
                    // Return the video details as JSON response
                    echo json_encode([
                        "status" => true,
                        "message" => "Video details fetched successfully.",
                        "data" => $videoDetails
                    ]);
                } else {
                    // No records found for the provided patient_id
                    echo json_encode([
                        "status" => false,
                        "message" => "No video details found for the provided patient_id."
                    ]);
                }
            } else {
                // Error executing the query
                echo json_encode([
                    "status" => false,
                    "message" => "Error fetching video details: " . $stmt->error
                ]);
            }

            // Close the statement
            $stmt->close();
        } else {
            // 'patient_id' parameter is missing
            echo json_encode([
                "status" => false,
                "message" => "Missing 'patient_id' parameter."
            ]);
        }
    } 







?>
