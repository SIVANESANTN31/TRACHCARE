<?php 
include "../config/conn.php";

// Received JSON into $json variable
$json = file_get_contents('php://input');

// Decoding the received JSON and storing it in $obj variable
$obj = json_decode($json, true);

// Check if required fields are present in the request
if(isset($obj["username"], $obj["email"], $obj["phone_number"], $obj["password"], $obj["doctor_reg_no"], )) {

    // Escape variables for security
    $username = mysqli_real_escape_string($conn, $obj['username']);
    $doctor_reg_no = mysqli_real_escape_string($conn, $obj['doctor_reg_no']);
    $email = mysqli_real_escape_string($conn, $obj['email']);
    $phone_number = mysqli_real_escape_string($conn, $obj['phone_number']);
    $password = mysqli_real_escape_string($conn, $obj['password']);
    $image_data = isset($obj['image_data']) ? $obj['image_data'] : null;

    $idgen = rand(100, 100000);
    $doctorId = (string)$idgen . $doctor_reg_no;

    // Handle image upload if provided
    $image_file = null;
    if ($image_data !== null) {
        
            // Decode the base64 data
            $image = base64_decode($image_data);

            // Get image info
            $imageInfo = getimagesizefromstring($image);
            if ($imageInfo === false) {
                echo json_encode(["status" => false, "msg" => "Invalid image data"]);
                exit;
            }

            // Determine MIME type and generate filename
            $mimeType = $imageInfo['mime'];
           
            

            // Determine file extension based on MIME type
            switch ($mimeType) {
                case 'image/jpeg':
                    $filenames = uniqid() . ".jpeg";
                    break;
                case 'image/png':
                    $filenames = uniqid() . ".png";
                    break;
                case 'image/jpg':
                    $filenames = uniqid() . ".jpg";
                    break;
                default:
                    echo json_encode(["status" => false, "msg" => "Unknown image format"]);
                    exit;
            }

            // Define the file path where the image will be saved
            $filePath = "../uploads/" . $filenames;

            // Save the image file
            if (file_put_contents($filePath, $imageData) === false) {
                echo json_encode(["status" => false, "msg" => "Failed to save image"]);
                exit;
            }
         
        $insert_sql = "INSERT INTO doctorprofile (doctor_id ,username, doctor_reg_no, email, phone_number, password, image_path) 
                   VALUES ('$doctorId','$username', '$doctor_reg_no', '$email', '$phone_number', '$password', '$filePath')";
    }
    // Prepare the insert query
    else{
        $insert_sql = "INSERT INTO doctorprofile (doctor_id ,username, doctor_reg_no, email, phone_number, password, image_path) 
                   VALUES ('$doctorId','$username', '$doctor_reg_no', '$email', '$phone_number', '$password', '$image_file')";
    }
    // Execute the query
    if ($conn->query($insert_sql) === TRUE) {
        $response['Status'] = true;
        $response['message'] = "New user created successfully.";
    } else {
        $response['Status'] = false;
        $response['message'] = "Error: " . $insert_sql . "<br>" . $conn->error;
    }

} else {
    // If required fields are missing, set the Status to false and provide a message
    $response['Status'] = false;
    $response['message'] = "Required fields are missing.";
}

// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;

?>
