<?php
 include "../config/conn.php";

 $method = $_SERVER['REQUEST_METHOD'];

if($method=="POST"){
 uploadvideos($conn);
 }
 elseif($method=="GET"){
    fetchVideoDetails($conn);


 }

 function uploadvideos($conn) {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $title = $_POST['title'];
        $description = $_POST['description'];
        $uploadVideoDir = '../uploads/videos/';
        $uploadThumbnailDir = '../uploads/thumbnails/';
        $result = [];

        // Ensure directories exist
        if (!is_dir($uploadVideoDir)) {
            mkdir($uploadVideoDir, 0777, true);
        }
        if (!is_dir($uploadThumbnailDir)) {
            mkdir($uploadThumbnailDir, 0777, true);
        }

        // Check if both video and thumbnail files were uploaded
        if (!isset($_FILES['videoFile']) || !isset($_FILES['thumbnailImage'])) {
            echo json_encode(["status" => false, "msg" => "Video or thumbnail file is missing."]);
            exit;
        }

        // Get the uploaded video file information
        $videoFile = $_FILES['videoFile'];
        $videoName = basename($videoFile['name']);
        $id = rand(100, 100000);
        $uploadVideoPath = $uploadVideoDir . (string)$id . $videoName;

        // Validate video and thumbnail types (remaining code)

        // Allowed video types by MIME and extension
        $allowedVideoTypes = ['video/mp4', 'video/avi', 'video/mov', 'video/mkv'];
        $allowedVideoExtensions = ['mp4', 'avi', 'mov', 'mkv'];

        // Validate the video file type by MIME and extension
        $videoFileType = mime_content_type($videoFile['tmp_name']);
        $videoFileExtension = strtolower(pathinfo($videoFile['name'], PATHINFO_EXTENSION));
        
        if (!in_array($videoFileType, $allowedVideoTypes) && 
            !($videoFileType === 'application/octet-stream' && in_array($videoFileExtension, $allowedVideoExtensions))) {
            echo json_encode(["status" => false, "msg" => "Invalid video format. Only MP4, AVI, MOV, and MKV are allowed."]);
            exit;
        }

        // Get the uploaded thumbnail file information
        $thumbnailFile = $_FILES['thumbnailImage'];
        $thumbnailName = basename($thumbnailFile['name']);
        $uploadThumbnailPath = $uploadThumbnailDir . (string)$id . $thumbnailName;

        // Allowed image types by MIME and extension
        $allowedImageTypes = ['image/jpeg', 'image/png', 'image/jpg'];
        $allowedImageExtensions = ['jpeg', 'jpg', 'png'];

        // Validate the thumbnail file type by MIME and extension
        $thumbnailFileType = mime_content_type($thumbnailFile['tmp_name']);
        $thumbnailFileExtension = strtolower(pathinfo($thumbnailFile['name'], PATHINFO_EXTENSION));

        if (!in_array($thumbnailFileType, $allowedImageTypes) &&
            !($thumbnailFileType === 'application/octet-stream' && in_array($thumbnailFileExtension, $allowedImageExtensions))) {
            echo json_encode(["status" => false, "msg" => "Invalid thumbnail format. Only JPEG, PNG, and JPG are allowed."]);
            exit;
        }


        // Move both files to their respective directories
        if (move_uploaded_file($videoFile['tmp_name'], $uploadVideoPath) &&
            move_uploaded_file($_FILES['thumbnailImage']['tmp_name'], $uploadThumbnailPath)) {

            // Insert video and thumbnail data into the database
            $sql = "INSERT INTO patientvideotable (title, description, Video_url, Thumbnail_url) VALUES ('$title', '$description', '$uploadVideoPath', '$uploadThumbnailPath')";
            
            $stmt = $conn->prepare($sql);

            if ($stmt === false) {
                die("Error preparing statement: " . $conn->error);
            }

            if ($stmt->execute()) {
                $result['status'] = true;
                $result['message'] = "Video and thumbnail uploaded successfully.";
            } else {
                $result['status'] = false;
                $result['message'] = "Error updating video details: " . $stmt->error;
            }

            $stmt->close();
            echo json_encode($result);
        } else {
            echo json_encode(["status" => false, "msg" => "Failed to upload video or thumbnail."]);
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

 
        if ($_SERVER['REQUEST_METHOD'] == 'GET') {
           

            // Prepare the SQL query to fetch video details
            $sql = "SELECT  * FROM patientvideotable ";
            
            // Prepare the statement
            $stmt = $conn->prepare($sql);

            if ($stmt === false) {
                die("Error preparing statement: " . $conn->error);
            }

            // Bind the 'patient_id' parameter to the SQL statement
            

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
                        "message" => "No video Availalbe",
                        "data" => []
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