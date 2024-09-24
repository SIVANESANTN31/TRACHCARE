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
   // No need for submit check here, we directly proceed with file upload
$doctorid = $_POST['doctorid'];
$patient_id = $_POST['patient_id'];

// Check if the file is uploaded properly
if (isset($_FILES['video']) && $_FILES['video']['error'] == 0) {
    // File upload configuration
    $targetDir = "uploads/videos/";
    
    // Check if the directory exists, if not create it
    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0755, true); // Creates the directory if it doesn't exist
    }

    $fileName = basename($_FILES["video"]["name"]);
    $targetFilePath = $targetDir . $fileName;
    $fileType = pathinfo($targetFilePath, PATHINFO_EXTENSION);

    // Allow certain file formats
    $allowedTypes = array('mp4', 'avi', '3gp', 'mov', 'mpeg');
    if (in_array($fileType, $allowedTypes)) {
        // Upload file to server
        if (move_uploaded_file($_FILES["video"]["tmp_name"], $targetFilePath)) {
            // Insert video file name into database
            $insert = $conn->query("INSERT INTO patientvideotable (doctorid, patient_id, Video_url) VALUES ('$doctorid', '$patient_id', '$targetFilePath')");
            if ($insert) {
                echo "The file " . htmlspecialchars($fileName) . " has been uploaded successfully.";
            } else {
                echo "Failed to insert into the database: " . $conn->error;
            }
        } else {
            echo "Sorry, there was an error uploading your file.";
        }
    } else {
        echo "Sorry, only MP4, AVI, 3GP, MOV, & MPEG files are allowed to upload.";
    }
} else {
    echo "No file uploaded or there was an error uploading the file.";
}

// Close the database connection
$conn->close();

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
