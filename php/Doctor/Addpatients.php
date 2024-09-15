<?php

include '../config/conn.php';



$method = $_SERVER['REQUEST_METHOD'];

if ($method =='POST'){
    Addpatient($conn);
}
elseif ($method =='DELETE'){
    DeletePatient($conn);

}
elseif ($method =='PUT'){
    UpdatePatient($conn);

}
elseif ($method =='GET'){
    GetPatientsdetials($conn);
}
else{
    echo json_encode("invalid request method");
    $conn->close();
}






function Addpatient($conn) {
    // Get JSON input from the request body
    $json = file_get_contents('php://input');

    // Decode JSON into an associative array
    $obj = json_decode($json, true);
    $result=[];
    // Check if JSON is decoded successfully
    if ($obj === null) {
        die("Invalid JSON data.");
    }

    

    // Extract values from the associative array
    $doctorId = $obj['doctorid'];
    $name = $obj['name'];
    $age = $obj['age'];
    $address = $obj['address'];
    $bmi = $obj['bmi'];
    $diagnosis = $obj['diagnosis'];
    $surgeryStatus = $obj['surgery_status'];
    $postOp = $obj['postop'];
    $tubeNameAndSize = $obj['tubenameandsize'];
    $baselineVitals = $obj['baselinvitals'];
    $respiratoryRate = $obj['respiratory_rate'];
    $heartRate = $obj['heart_rate'];
    $spo2Room = $obj['Spo2@room'];
    $indicationOfTracheostomy = $obj['INDICATION OF TRACHEOSTOMY'];
    $comorbidities = $obj['COMORBIDITIES'];
    $hemoglobin = $obj['HEMOGLOBIN'];
    $srSodium = $obj['SR. SODIUM'];
    $srPotassium = $obj['SR. POTASSIUM'];
    $srCalcium = $obj['SR. CALCIUM'];
    $srBicarbonate = $obj['SR. BICARBONATE'];
    $pt = $obj['Pt'];
    $aptt = $obj['APTT'];
    $inr = $obj['INR'];
    $platelets = $obj['PLATELETS'];
    $liverFunctionTest = $obj['LIVER FUNCTION TEST'];
    $renalFunctionTest = $obj['RENAL FUNCTION TEST'];
  //  $patientImagePath = $obj['Patient_imag_path'];
  $idgen = rand(100, 100000);
    $name =  str_replace(' ', '', $name);
  $patientId = (string)$idgen . $name;
    if( isset($obj['Patient_imag_path'])){
        $base64Image = $obj['Patient_imag_path'];

        // Check if base64Image is set and not empty
        if (!empty($base64Image)) {
            // Decode the base64 data
            $imageData = base64_decode($base64Image);

            // Get image info
            $imageInfo = getimagesizefromstring($imageData);
            if ($imageInfo === false) {
                echo json_encode(["status" => false, "msg" => "Invalid image data"]);
                exit;
            }

            // Determine MIME type and generate filename
            $mimeType = $imageInfo['mime'];
            $number = rand(100, 100000);
            $generateFilename = (string)$number . $name;
            $filenames = '';

            

            // Determine file extension based on MIME type
            switch ($mimeType) {
                case 'image/jpeg':
                    $filenames = $generateFilename . ".jpeg";
                    break;
                case 'image/png':
                    $filenames = $generateFilename . ".png";
                    break;
                case 'image/jpg':
                    $filenames = $generateFilename . ".jpg";
                    break;
                default:
                    echo json_encode(["status" => false, "msg" => "Unknown image format"]);
                    exit;
            }

            // Define the file path where the image will be saved
            $filePath = "../uploads/patient_images/" . $filenames;

            // Save the image file
            if (file_put_contents($filePath, $imageData) === false) {
                echo json_encode(["status" => false, "msg" => "Failed to save image"]);
                exit;
            }
        } else {
            // Handle case where base64Image is not set or empty
            $filePath = '../uploads/patient_images/default.jpg';
        }
    }

   


  
    // Prepare the SQL insert statement with placeholders
    $sql = "INSERT INTO addpatient (
                doctorid, patient_id, name, age, address, bmi, diagnosis, surgery_status, postop, 
                tubenameandsize, baselinvitals, respiratory_rate, heart_rate, Spo2_AT_room, INDICATIONOFTRACHEOSTOMY, 
                COMORBIDITIES,HEMOGLOBIN,SRSODIUM,SRPOTASSIUM,SRCALCIUM,SRBICARBONATE, 
                Pt, APTT, INR, PLATELETS, LIVERFUNCTIONTEST,RENALFUNCTIONTEST,Patient_imag_path
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    // Prepare the statement
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        die("Error preparing statement: " . $conn->error);
    }

    // Bind parameters to the SQL statement
    $stmt->bind_param(
        "ssssssssssssssssssssssssssss",
        $doctorId, $patientId, $name, $age, $address, $bmi, $diagnosis, $surgeryStatus, $postOp,
        $tubeNameAndSize, $baselineVitals, $respiratoryRate, $heartRate, $spo2Room, $indicationOfTracheostomy,
        $comorbidities, $hemoglobin, $srSodium, $srPotassium, $srCalcium, $srBicarbonate,
        $pt, $aptt, $inr, $platelets, $liverFunctionTest, $renalFunctionTest, $filePath
    );

    // Execute the statement
    if ($stmt->execute()) {
        $result['Status']=true;

      $result['message']="Successfully Patient Added";
      echo json_encode($result);
    } else {

        $result['Status']=false;

      $result['message']= $stmt->error;
      echo json_encode($result);
        
    }

    // Close the statement and connection
    $stmt->close();
    $conn->close();
}



function DeletePatient($conn) {
    // Get JSON input from the request body
    $json = file_get_contents('php://input');

    // Decode JSON into an associative array
    $obj = json_decode($json, true);
    $result = [];

    // Check if JSON is decoded successfully
    if ($obj === null) {
        die("Invalid JSON data.");
    }

    // Extract the patient ID from the associative array
    $patientId = $obj['patient_id'];

    // Prepare the SQL delete statement with a placeholder
    $sql = "DELETE FROM addpatient WHERE patient_id = ?";

    // Prepare the statement
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        die("Error preparing statement: " . $conn->error);
    }

    // Bind the patient ID to the SQL statement
    $stmt->bind_param("s", $patientId);

    // Execute the statement
    if ($stmt->execute()) {
        $result['Status'] = true;
        $result['message'] = "Patient successfully deleted.";
    } else {
        $result['Status'] = false;
        $result['message'] = "Error deleting patient: " . $stmt->error;
    }

    // Output the result as JSON
    echo json_encode($result);

    // Close the statement and connection
    $stmt->close();
    $conn->close();
}



function UpdatePatient($conn) {
    // Get JSON input from the request body
    $json = file_get_contents('php://input');

    // Decode JSON into an associative array
    $obj = json_decode($json, true);
    $result = [];

    // Check if JSON is decoded successfully
    if ($obj === null) {
        die("Invalid JSON data.");
    }

    // Extract values from the associative array
    $patientId = $obj['patient_id'];  // The patient ID that we want to update
    $doctorId = $obj['doctorid'];
    $name = $obj['name'];
    $age = $obj['age'];
    $address = $obj['address'];
    $bmi = $obj['bmi'];
    $diagnosis = $obj['diagnosis'];
    $surgeryStatus = $obj['surgery_status'];
    $postOp = $obj['postop'];
    $tubeNameAndSize = $obj['tubenameandsize'];
    $baselineVitals = $obj['baselinvitals'];
    $respiratoryRate = $obj['respiratory_rate'];
    $heartRate = $obj['heart_rate'];
    $spo2Room = $obj['Spo2@room'];
    $indicationOfTracheostomy = $obj['INDICATION OF TRACHEOSTOMY'];
    $comorbidities = $obj['COMORBIDITIES'];
    $hemoglobin = $obj['HEMOGLOBIN'];
    $srSodium = $obj['SR. SODIUM'];
    $srPotassium = $obj['SR. POTASSIUM'];
    $srCalcium = $obj['SR. CALCIUM'];
    $srBicarbonate = $obj['SR. BICARBONATE'];
    $pt = $obj['Pt'];
    $aptt = $obj['APTT'];
    $inr = $obj['INR'];
    $platelets = $obj['PLATELETS'];
    $liverFunctionTest = $obj['LIVER FUNCTION TEST'];
    $renalFunctionTest = $obj['RENAL FUNCTION TEST'];

    // Check if there's an image to update
    if (isset($obj['Patient_imag_path'])) {
        $base64Image = $obj['Patient_imag_path'];

        // Decode and save the image if present
        if (!empty($base64Image)) {
            $imageData = base64_decode($base64Image);
            $imageInfo = getimagesizefromstring($imageData);
            if ($imageInfo === false) {
                echo json_encode(["status" => false, "msg" => "Invalid image data"]);
                exit;
            }

            $mimeType = $imageInfo['mime'];
            $number = rand(100, 100000);
            $generateFilename = (string)$number . $name;
            $filenames = '';

            // Determine file extension
            switch ($mimeType) {
                case 'image/jpeg':
                    $filenames = $generateFilename . ".jpeg";
                    break;
                case 'image/png':
                    $filenames = $generateFilename . ".png";
                    break;
                case 'image/jpg':
                    $filenames = $generateFilename . ".jpg";
                    break;
                default:
                    echo json_encode(["status" => false, "msg" => "Unknown image format"]);
                    exit;
            }

            // Define the file path
            $filePath = "../uploads/patient_images/" . $filenames;

            // Save the image
            if (file_put_contents($filePath, $imageData) === false) {
                echo json_encode(["status" => false, "msg" => "Failed to save image"]);
                exit;
            }
        } else {
            $filePath = '../uploads/patient_images/default.jpg'; // Fallback image path
        }
    } else {
        $filePath = null; // No image update
    }

    // Prepare the SQL update statement with placeholders
    $sql = "UPDATE addpatient SET
                doctorid = ?, name = ?, age = ?, address = ?, bmi = ?, diagnosis = ?, surgery_status = ?, postop = ?, 
                tubenameandsize = ?, baselinvitals = ?, respiratory_rate = ?, heart_rate = ?, Spo2_AT_room = ?, 
                INDICATIONOFTRACHEOSTOMY = ?, COMORBIDITIES = ?, HEMOGLOBIN = ?, SRSODIUM = ?, SRPOTASSIUM = ?, 
                SRCALCIUM = ?, SRBICARBONATE = ?, Pt = ?, APTT = ?, INR = ?, PLATELETS = ?, LIVERFUNCTIONTEST = ?, 
                RENALFUNCTIONTEST = ?";

    // Append image path update only if an image was provided
    if ($filePath !== null) {
        $sql .= ", Patient_imag_path = ?";
    }

    $sql .= " WHERE patient_id = ?";

    // Prepare the statement
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        die("Error preparing statement: " . $conn->error);
    }

    // Bind parameters to the SQL statement
    if ($filePath !== null) {
        $stmt->bind_param(
            "ssssssssssssssssssssssssssss",
            $doctorId, $name, $age, $address, $bmi, $diagnosis, $surgeryStatus, $postOp,
            $tubeNameAndSize, $baselineVitals, $respiratoryRate, $heartRate, $spo2Room, 
            $indicationOfTracheostomy, $comorbidities, $hemoglobin, $srSodium, $srPotassium, 
            $srCalcium, $srBicarbonate, $pt, $aptt, $inr, $platelets, $liverFunctionTest, 
            $renalFunctionTest, $filePath, $patientId
        );
    } else {
        $stmt->bind_param(
            "ssssssssssssssssssssssssss",
            $doctorId, $name, $age, $address, $bmi, $diagnosis, $surgeryStatus, $postOp,
            $tubeNameAndSize, $baselineVitals, $respiratoryRate, $heartRate, $spo2Room, 
            $indicationOfTracheostomy, $comorbidities, $hemoglobin, $srSodium, $srPotassium, 
            $srCalcium, $srBicarbonate, $pt, $aptt, $inr, $platelets, $liverFunctionTest, 
            $renalFunctionTest, $patientId
        );
    }

    // Execute the statement
    if ($stmt->execute()) {
        $result['Status'] = true;
        $result['message'] = "Patient details updated successfully.";
    } else {
        $result['Status'] = false;
        $result['message'] = "Error updating patient details: " . $stmt->error;
    }

    // Output the result as JSON
    echo json_encode($result);

    // Close the statement and connection
    $stmt->close();
    $conn->close();
}



function GetPatientsdetials($conn) {
    // Retrieve the doctor ID from the GET request
    if (!isset($_GET['doctorid'])) {
        echo json_encode(["status" => false, "msg" => "Doctor ID not provided"]);
        return;
    }

    $doctorId = $_GET['doctorid'];

    // Prepare the SQL SELECT statement to fetch patients associated with the doctor ID
    $sql = "SELECT 
                doctorid, patient_id, name, age, address, bmi, diagnosis, surgery_status, postop,
                tubenameandsize, baselinvitals, respiratory_rate, heart_rate, Spo2_AT_room, 
                INDICATIONOFTRACHEOSTOMY, COMORBIDITIES, HEMOGLOBIN, SRSODIUM, SRPOTASSIUM, 
                SRCALCIUM, SRBICARBONATE, Pt, APTT, INR, PLATELETS, LIVERFUNCTIONTEST, 
                RENALFUNCTIONTEST, Patient_imag_path
            FROM addpatient 
            WHERE doctorid = ?";

    // Prepare the statement
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        echo json_encode(["status" => false, "msg" => "Error preparing statement: " . $conn->error]);
        return;
    }

    // Bind the doctor ID parameter to the SQL statement
    $stmt->bind_param("s", $doctorId);

    // Execute the statement
    if ($stmt->execute()) {
        // Get the result set from the executed statement
        $result = $stmt->get_result();

        // Check if any records were found
        if ($result->num_rows > 0) {
            // Fetch all records as an associative array
            $patients = $result->fetch_all(MYSQLI_ASSOC);

            // Return the records as a JSON response
            echo json_encode(["status" => true, "data" => $patients]);
        } else {
            // No records found for the given doctor ID
            echo json_encode(["status" => false, "msg" => "No patients found for this doctor ID"]);
        }
    } else {
        // If the statement execution fails
        echo json_encode(["status" => false, "msg" => "Error executing query: " . $stmt->error]);
    }

    // Close the statement and connection
    $stmt->close();
    $conn->close();
}
?>