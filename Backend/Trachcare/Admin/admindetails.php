<?php

include '../config/conn.php';

// Handle incoming requests
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['doctor_id'])) {
    getDoctor($conn, $_GET['doctor_id']);
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['doctor_id'])) {
        updateDoctor($conn, $_POST);
    } else {
        echo json_encode(['Status' => false, 'message' => 'doctor_id is required for update']);
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'DELETE' && isset($_GET['doctor_id'])) {
    deleteDoctor($conn, $_GET['doctor_id']);
} else {
    echo json_encode(['Status' => false, 'message' => 'Invalid request']);
}

function getDoctor($conn, $id) {
    $id = mysqli_real_escape_string($conn, $id);
    $result = [];

    $sql = "SELECT * FROM adminlogin WHERE doctor_id='{$id}'";
    $res = $conn->query($sql);

    if ($res->num_rows > 0) {
        $row = $res->fetch_assoc();
        $result['Status'] = true;
        $result['message'] = "Successfully retrieved the doctor details.";
        $result["doctorInfo"] = $row;
    } else {
        $result['Status'] = false;
        $result['message'] = "Failed to retrieve the doctor details.";
        $result['doctorInfo'] = null;
    }

    echo json_encode($result);
}

function deleteDoctor($conn, $id) {
    $id = mysqli_real_escape_string($conn, $id);
    $result = [];

    $sql = "DELETE FROM adminlogin WHERE doctor_id='{$id}'";

    if ($conn->query($sql) === TRUE) {
        $result['Status'] = true;
        $result['message'] = "Doctor deleted successfully.";
    } else {
        $result['Status'] = false;
        $result['message'] = "Error deleting doctor: " . $conn->error;
    }

    echo json_encode($result);
}

function updateDoctor($conn, $data) {
    $doctor_id = isset($data['doctor_id']) ? mysqli_real_escape_string($conn, $data['doctor_id']) : null;
    $username = isset($data['username']) ? mysqli_real_escape_string($conn, $data['username']) : null;
    $doctor_reg_no = isset($data['doctor_reg_no']) ? mysqli_real_escape_string($conn, $data['doctor_reg_no']) : null;
    $email = isset($data['email']) ? mysqli_real_escape_string($conn, $data['email']) : null;
    $phone_number = isset($data['phone_number']) ? mysqli_real_escape_string($conn, $data['phone_number']) : null;
    $password = isset($data['password']) ? mysqli_real_escape_string($conn, $data['password']) : null;
    $created_at = isset($data['created_at']) ? mysqli_real_escape_string($conn, $data['created_at']) : null;

    $fields = [];
    if ($username !== null) {
        $fields[] = "username='{$username}'";
    }
    if ($doctor_reg_no !== null) {
        $fields[] = "doctor_reg_no='{$doctor_reg_no}'";
    }
    if ($email !== null) {
        $fields[] = "email='{$email}'";
    }
    if ($phone_number !== null) {
        $fields[] = "phone_number='{$phone_number}'";
    }
    if ($password !== null) {
        $fields[] = "password='{$password}'"; // Consider hashing the password
    }
    if (isset($_FILES['image']) && $_FILES['image']['name'] != "") {
        // Upload image if provided
        $image_path = uploadImage($_FILES['image']);
        if ($image_path !== null) {
            $fields[] = "image_path='{$image_path}'";
        } else {
            echo json_encode(['Status' => false, 'message' => 'Image upload failed']);
            return;
        }
    }

    $result = [];
    
    if (count($fields) > 0) {
        $sql = "UPDATE adminlogin SET " . implode(", ", $fields) . " WHERE doctor_id='{$doctor_id}'";

        if ($conn->query($sql) === TRUE) {
            $result['Status'] = true;
            $result['message'] = "Doctor details updated successfully.";
        } else {
            $result['Status'] = false;
            $result['message'] = "Error updating doctor: " . $conn->error;
        }
    } else {
        $result['Status'] = false;
        $result['message'] = "No fields to update.";
    }

    echo json_encode($result);
}

function uploadImage($file) {
    $target_dir = "../uploads/admin/";
    $target_file = $target_dir . basename($file["name"]);
    $uploadOk = 1;
    $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

    // Check if image file is an actual image or fake image
    $check = getimagesize($file["tmp_name"]);
    if ($check === false) {
        $uploadOk = 0;
    }

    // Check file size
    if ($file["size"] > 500000) { // 500 KB limit
        $uploadOk = 0;
    }

    // Allow certain file formats
    if ($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif") {
        $uploadOk = 0;
    }

    // Check if $uploadOk is set to 0 by an error
    if ($uploadOk == 0) {
        return null; // Return null if upload fails
    } else {
        if (move_uploaded_file($file["tmp_name"], $target_file)) {
            return $target_file; // Return the file path on success
        } else {
            return null;
        }
    }
}

?>
