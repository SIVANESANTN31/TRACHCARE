<?php

include '../config/conn.php';

// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
    $response = [];

    // Check if the form data is received via POST
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Retrieve and sanitize form data
        $doctor_id = isset($_POST['doctor_id']) ? mysqli_real_escape_string($conn, $_POST['doctor_id']) : null;
        $username = isset($_POST['username']) ? mysqli_real_escape_string($conn, $_POST['username']) : null;
        $email = isset($_POST['email']) ? mysqli_real_escape_string($conn, $_POST['email']) : null;
        $phone_number = isset($_POST['phone_number']) ? mysqli_real_escape_string($conn, $_POST['phone_number']) : null;
        $password = isset($_POST['password']) ? mysqli_real_escape_string($conn, $_POST['password']) : null;
        $age = isset($_POST['age']) ? mysqli_real_escape_string($conn, $_POST['age']) : null;
        $address = isset($_POST['address']) ? mysqli_real_escape_string($conn, $_POST['address']) : null;
        $bmi = isset($_POST['bmi']) ? mysqli_real_escape_string($conn, $_POST['bmi']) : null;
        $diagnosis = isset($_POST['diagnosis']) ? mysqli_real_escape_string($conn, $_POST['diagnosis']) : null;
        $surgery_status = isset($_POST['surgery_status']) ? mysqli_real_escape_string($conn, $_POST['surgery_status']) : null;
        $post_op_tracheostomy_day = isset($_POST['post_op_tracheostomy_day']) ? mysqli_real_escape_string($conn, $_POST['post_op_tracheostomy_day']) : null;
        $tube_name_size = isset($_POST['tube_name_size']) ? mysqli_real_escape_string($conn, $_POST['tube_name_size']) : null;
        $baseline_vitals = isset($_POST['baseline_vitals']) ? mysqli_real_escape_string($conn, $_POST['baseline_vitals']) : null;
        $respiratory_rate = isset($_POST['respiratory_rate']) ? mysqli_real_escape_string($conn, $_POST['respiratory_rate']) : null;
        $heart_rate = isset($_POST['heart_rate']) ? mysqli_real_escape_string($conn, $_POST['heart_rate']) : null;
        $spo2_room_air = isset($_POST['spo2_room_air']) ? mysqli_real_escape_string($conn, $_POST['spo2_room_air']) : null;
        $indication_of_tracheostomy = isset($_POST['indication_of_tracheostomy']) ? mysqli_real_escape_string($conn, $_POST['indication_of_tracheostomy']) : null;
        $comorbidities = isset($_POST['comorbidities']) ? mysqli_real_escape_string($conn, $_POST['comorbidities']) : null;
        $hemoglobin = isset($_POST['hemoglobin']) ? mysqli_real_escape_string($conn, $_POST['hemoglobin']) : null;
        $sr_sodium = isset($_POST['sr_sodium']) ? mysqli_real_escape_string($conn, $_POST['sr_sodium']) : null;
        $sr_potassium = isset($_POST['sr_potassium']) ? mysqli_real_escape_string($conn, $_POST['sr_potassium']) : null;
        $sr_calcium = isset($_POST['sr_calcium']) ? mysqli_real_escape_string($conn, $_POST['sr_calcium']) : null;
        $sr_bicarbonate = isset($_POST['sr_bicarbonate']) ? mysqli_real_escape_string($conn, $_POST['sr_bicarbonate']) : null;
        $pt = isset($_POST['pt']) ? mysqli_real_escape_string($conn, $_POST['pt']) : null;
        $aptt = isset($_POST['aptt']) ? mysqli_real_escape_string($conn, $_POST['aptt']) : null;
        $inr = isset($_POST['inr']) ? mysqli_real_escape_string($conn, $_POST['inr']) : null;
        $platelets = isset($_POST['platelets']) ? mysqli_real_escape_string($conn, $_POST['platelets']) : null;
        $liver_function_test = isset($_POST['liver_function_test']) ? mysqli_real_escape_string($conn, $_POST['liver_function_test']) : null;
        $renal_function_test = isset($_POST['renal_function_test']) ? mysqli_real_escape_string($conn, $_POST['renal_function_test']) : null;
        
        // Handle image upload
        $image_file = isset($_FILES['image_path']) ? $_FILES['image_path'] : null;
        $default_image = "../uploads/patient.png";
        
        // Generate a unique patient_id
        $idgen = rand(100, 100000);
        // Remove any spaces or special characters from the username for the patient_id
        $patient_id = (string)$idgen . $username;

        // Validate required fields
        // List of required fields can be adjusted as needed
        $required_fields = [
            $doctor_id, $username, $email, $phone_number, $password,
            $age, $address, $bmi, $diagnosis, $surgery_status,
            $post_op_tracheostomy_day, $tube_name_size, $baseline_vitals,
            $respiratory_rate, $heart_rate, $spo2_room_air,
            $indication_of_tracheostomy, $comorbidities, $hemoglobin,
            $sr_sodium, $sr_potassium, $sr_calcium, $sr_bicarbonate,
            $pt, $aptt, $inr, $platelets, $liver_function_test,
            $renal_function_test
        ];

        // Check if any required field is missing
        $all_fields_present = true;
        foreach ($required_fields as $field) {
            if (is_null($field)) {
                $all_fields_present = false;
                break;
            }
        }

        // Proceed only if all required fields are present
        if ($all_fields_present) {
            // Handle image upload if an image file is provided
            if ($image_file && $image_file['error'] === UPLOAD_ERR_OK) {
                // Validate the uploaded image
                $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
                $mimeType = mime_content_type($image_file['tmp_name']);

                if (!in_array($mimeType, $allowedTypes)) {
                    echo json_encode(["status" => false, "msg" => "Unsupported image format.", "mime_type" => $mimeType]);
                    exit;
                }

                // Generate a unique filename
                $filename = uniqid('patient_', true) . '.' . pathinfo($image_file['name'], PATHINFO_EXTENSION);
                $filePath = "../uploads/patient_images/" . $filename;

                // Move the uploaded file to the designated folder
                if (!move_uploaded_file($image_file['tmp_name'], $filePath)) {
                    echo json_encode(["status" => false, "msg" => "Failed to save image."]);
                    exit;
                }
            } else {
                // Use default image if no image is uploaded
                $filePath = $default_image;
            }

            // Check if the patient_id already exists
            $check_sql = "SELECT * FROM addpatients WHERE patient_id = '$patient_id'";
            $result = $conn->query($check_sql);

            if ($result->num_rows > 0) {
                // If patient_id exists, send a duplicate error response
                $response['Status'] = false;
                $response['msg'] = "Patient ID '$patient_id' already exists. Please try again.";
            } else {
                // Prepare the insert query using prepared statements to prevent SQL injection
                $insert_sql = "INSERT INTO addpatients (
                                    doctor_id, patient_id, username, email, phone_number, password, age, address, bmi, diagnosis,
                                    surgery_status, post_op_tracheostomy_day, tube_name_size, baseline_vitals, respiratory_rate, 
                                    heart_rate, spo2_room_air, indication_of_tracheostomy, comorbidities, hemoglobin,
                                    sr_sodium, sr_potassium, sr_calcium, sr_bicarbonate, pt, aptt, inr, platelets, liver_function_test, renal_function_test,
                                    image_path
                                ) VALUES (
                                    '$doctor_id', '$patient_id', '$username', '$email', '$phone_number', '$password', '$age', '$address', '$bmi', '$diagnosis',
                                    '$surgery_status', '$post_op_tracheostomy_day', '$tube_name_size', '$baseline_vitals', '$respiratory_rate', 
                                    '$heart_rate', '$spo2_room_air', '$indication_of_tracheostomy', '$comorbidities', '$hemoglobin', 
                                    '$sr_sodium', '$sr_potassium', '$sr_calcium', '$sr_bicarbonate', '$pt', '$aptt', '$inr', '$platelets', '$liver_function_test', '$renal_function_test', '$filePath'
                                )";

                // Execute the query
                if ($conn->query($insert_sql) === TRUE) {
                    $response['Status'] = true;
                    $response['msg'] = "Patient added successfully.";
                } else {
                    $response['Status'] = false;
                    $response['msg'] = "Error: " . $conn->error;
                }
            }
        } else {
            $response['Status'] = false;
            $response['msg'] = "Required fields are missing.";
            $response['Statusss'] = $required_fields;
        }
    } else {
        $response['Status'] = false;
        $response['msg'] = "Invalid request method.";
    }

    // Convert the response array into JSON format
    $json_data = json_encode($response);

    // Echo the JSON data
    echo $json_data;




?>
