<?php 
include "../config/conn.php"; // Include your database connection file

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    adddoctors($conn);

}else{
    getdetials($conn);
}



function adddoctors($conn){
// Check if the form data is received via POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve form data
    $username = isset($_POST['username']) ? mysqli_real_escape_string($conn, $_POST['username']) : null;
    $email = isset($_POST['email']) ? mysqli_real_escape_string($conn, $_POST['email']) : null;
    $phone_number = isset($_POST['phone_number']) ? mysqli_real_escape_string($conn, $_POST['phone_number']) : null;
    $password = isset($_POST['password']) ? mysqli_real_escape_string($conn, $_POST['password']) : null;
    $doctor_reg_no = isset($_POST['doctor_reg_no']) ? mysqli_real_escape_string($conn, $_POST['doctor_reg_no']) : null;
    $image_file = isset($_FILES['image_data']) ? $_FILES['image_data'] : null;
    $default_image = "../uploads/doctor.png";
    $idgen = rand(100, 100000);
    $doctorId = (string)$idgen . $doctor_reg_no;

    // Validate required fields    
    if ($username && $email && $phone_number && $password && $doctor_reg_no && $image_file) {
      
        // Validate the uploaded image
        $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
        $mimeType = $image_file['type'];

        if (!in_array($mimeType, $allowedTypes)) {
            echo json_encode(["status" => false, "msg" => "Unsupported image format.","jfldjfkd"=>$mimeType]);
            exit;
        }

        // Generate a unique filename
        $filenames = uniqid() . '.' . pathinfo($image_file['name'], PATHINFO_EXTENSION);
        $filePath = "../uploads/doctorimages/" . $filenames;

        // Move the uploaded file to the designated folder
        if (!move_uploaded_file($image_file['tmp_name'], $filePath)) {
            echo json_encode(["status" => false, "msg" => "Failed to save image."]);
            exit;
        }

        // Prepare the insert query
        $insert_sql = "INSERT INTO doctorprofile (doctor_id, username, doctor_reg_no, email, phone_number, password, image_path) 
                       VALUES ('$doctorId', '$username', '$doctor_reg_no', '$email', '$phone_number', '$password', '$filePath')";

        // Execute the query
        if ($conn->query($insert_sql) === TRUE) {
            $response['Status'] = true;
            $response['msg'] = "New user created successfully.";
        } else {
            $response['Status'] = false;
            $response['msg'] = "Error: " . $insert_sql . "<br>" . $conn->error;
        }
    } else {
        if($image_file === null){
            // Prepare the insert query
            $insert_sql = "INSERT INTO doctorprofile (doctor_id, username, doctor_reg_no, email, phone_number, password, image_path) 
            VALUES ('$doctorId', '$username', '$doctor_reg_no', '$email', '$phone_number', '$password', '$default_image')";
     
                 // Execute the query
                 if ($conn->query($insert_sql) === TRUE) {
                 $response['Status'] = true;
                 $response['msg'] = "New user created successfully.";
                 } else {
                 $response['Status'] = false;
                 $response['msg'] = "Error: " . $insert_sql . "<br>" . $conn->error;
                 }} else{
        $response['Status'] = false;
        $response['msg'] = "Required fields are missing.";}
    }
} else {
    
    $response['Status'] = false;
    $response['msg'] = "Invalid request method.";
}


// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;
}

function getdetials($conn){



// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Retrieve the doctor ID from the query parameters
    $doctorId = isset($_GET['doctor_id']) ? mysqli_real_escape_string($conn, $_GET['doctor_id']) : null;

    // Validate the doctor ID
    if ($doctorId) {
        // Prepare the SQL query to fetch doctor details
        $query = "SELECT username, doctor_reg_no, email, phone_number, image_path FROM doctorprofile WHERE doctor_id = '$doctorId'";
        
        // Execute the query
        $result = $conn->query($query);

        if ($result) {
            // Check if any rows were returned
            if ($result->num_rows > 0) {
                // Fetch the doctor data
                $doctorData = $result->fetch_assoc();
                $response['Status'] = true;
                $response['data'] = $doctorData;
            } else {
                $response['Status'] = false;
                $response['message'] = "No doctor found with the provided ID.";
            }
        } else {
            $response['Status'] = false;
            $response['message'] = "Error executing query: " . $conn->error;
        }
    } else {
        $response['Status'] = false;
        $response['message'] = "Doctor ID is required.";
    }
} else {
    $response['Status'] = false;
    $response['message'] = "Invalid request method.";
}

// Convert the response array into JSON format
$json_data = json_encode($response);

// Echo the JSON data
echo $json_data;



}

?>
