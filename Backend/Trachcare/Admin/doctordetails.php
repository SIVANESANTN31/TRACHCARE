<?php

include '../config/conn.php';

function getDoctor($conn, $id) {
    $id = mysqli_real_escape_string($conn, $id);
    $result = [];

    $sql = "SELECT * FROM doctorprofile WHERE doctor_id='{$id}'";
    $res = $conn->query($sql);

    if ($res->num_rows > 0) {
        $row = $res->fetch_assoc();
        $result['Status'] = true;
        $result['message'] = "Successfully retrieved the id from the database.";
        $result["doctorInfo"] = $row;
    } else {
        $result['Status'] = false;
        $result['message'] = "Failed to retrieve the id from the database.";
        $result['doctorInfo'] = "Failed to retrieve the id from the database.";
    }

    echo json_encode($result);
}
function updateDoctor($conn, $data) {
    $doctor_id = mysqli_real_escape_string($conn, $data['doctor_id']);
    $username = isset($data['username']) ? mysqli_real_escape_string($conn, $data['username']) : null;
    $doctor_reg_no = isset($data['doctor_reg_no']) ? mysqli_real_escape_string($conn, $data['doctor_reg_no']) : null;
    $email = isset($data['email']) ? mysqli_real_escape_string($conn, $data['email']) : null;
    $phone_number = isset($data['phone_number']) ? mysqli_real_escape_string($conn, $data['phone_number']) : null;
    $password = isset($data['password']) ? mysqli_real_escape_string($conn, $data['password']) : null;
    $image_path = isset($data['image_path']) ? mysqli_real_escape_string($conn, $data['image_path']) : null;
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
    if ($image_path !== null) {
        $fields[] = "image_path='{$image_path}'";
    }
    if ($created_at !== null) {
        $fields[] = "created_at='{$created_at}'";
    }

    $result = [];
    
    if (count($fields) > 0) {
        $sql = "UPDATE doctorprofile SET " . implode(", ", $fields) . " WHERE doctor_id='{$doctor_id}'";

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

function deleteDoctor($conn, $id) {
    $id = mysqli_real_escape_string($conn, $id);
    $result = [];

    $sql = "DELETE FROM doctorprofile WHERE doctor_id='{$id}'";

    if ($conn->query($sql) === TRUE) {
        $result['Status'] = true;
        $result['message'] = "Doctor deleted successfully.";
    } else {
        $result['Status'] = false;
        $result['message'] = "Error deleting doctor: " . $conn->error;
    }

    echo json_encode($result);
}

// Handle incoming requests
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['doctor_id'])) {
    getDoctor($conn, $_GET['doctor_id']);
} elseif ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    $data = json_decode(file_get_contents("php://input"), true);
    if (isset($data['doctor_id'])) { // Check if doctor_id is provided
        updateDoctor($conn, $data);
    } else {
        echo json_encode(['Status' => false, 'message' => 'doctor_id is required for update']);
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'DELETE' && isset($_GET['doctor_id'])) {
    deleteDoctor($conn, $_GET['doctor_id']);
} else {
    echo json_encode(['Status' => false, 'message' => 'Invalid request']);
}

?>
