<?php

include '../config/conn.php';

function UploadVideoAndThumbnail($conn) {
    $target_dir = "uploads/";
    $response = array();

    // Check if it's a POST request
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        
        // Check if video file is uploaded
        if (!empty($_FILES['video']['name'])) {
            $video_name = basename($_FILES["video"]["name"]);
            $video_target = $target_dir . $video_name;
            
            // Upload video
            if (move_uploaded_file($_FILES["video"]["tmp_name"], $video_target)) {
                $response['video'] = "Video uploaded successfully";
            } else {
                $response['video'] = "Video upload failed";
            }
        } else {
            $response['video'] = "No video file uploaded";
        }

        // Check if thumbnail file is uploaded
        if (!empty($_FILES['thumbnail']['name'])) {
            $thumbnail_name = basename($_FILES["thumbnail"]["name"]);
            $thumbnail_target = $target_dir . $thumbnail_name;
            
            // Upload thumbnail
            if (move_uploaded_file($_FILES["thumbnail"]["tmp_name"], $thumbnail_target)) {
                $response['thumbnail'] = "Thumbnail uploaded successfully";
            } else {
                $response['thumbnail'] = "Thumbnail upload failed";
            }
        } else {
            $response['thumbnail'] = "No thumbnail file uploaded";
        }

        // Optionally, store details in the database (if needed)
        // Assuming you have a table called `videos` to store the file paths
        $sql = "INSERT INTO videos (video_path, thumbnail_path) VALUES (?, ?)";
        $stmt = $conn->prepare($sql);
        
        if ($stmt === false) {
            die("Error preparing statement: " . $conn->error);
        }

        $stmt->bind_param("ss", $video_target, $thumbnail_target);
        
        if ($stmt->execute()) {
            $response['db'] = "Video details saved to database";
        } else {
            $response['db'] = "Failed to save video details to database: " . $stmt->error;
        }

        $stmt->close();
        
    } else {
        echo json_encode(["message" => "Invalid request"]);
        return;
    }

    // Return the response as JSON
    echo json_encode($response);

    // Close the database connection
    $conn->close();
}

// Call the function to handle the request
UploadVideoAndThumbnail($conn);

?>
