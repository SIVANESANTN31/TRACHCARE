<?php
// Include database connection
include "config/conn.php";

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
?>
