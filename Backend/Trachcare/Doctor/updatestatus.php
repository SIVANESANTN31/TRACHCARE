<?php



include "../config/conn.php";
// echo json_encode($response);
date_default_timezone_set('Asia/Kolkata');

// Get current date and time in the format YYYY-MM-DD HH:MM:SS for Indian time zone
$current_time_ist = date("H");
// echo $current_time_ist
$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['patient_id']) && isset($_POST['issues'])){
        $id = $_POST['patient_id'];
        $issues = isset($_POST['issues']) ? (int)$_POST['issues'] : 0;
        if($current_time_ist >=10 && $current_time_ist <12){
            $sql = "UPDATE daily_stauts SET status_10 = 1, issues = ? WHERE patient_id = ?";

   
        }
       else if($current_time_ist >=12 && $current_time_ist <14){
            $sql = "UPDATE daily_stauts SET status_12 = 1, issues = ? WHERE patient_id = ?";

   
        }
       else if($current_time_ist >=14 && $current_time_ist <16){
            $sql = "UPDATE daily_stauts SET status_2 = 1, issues = ? WHERE patient_id = ?";

   
        }
        else if($current_time_ist >=16 && $current_time_ist <18){
            $sql = "UPDATE daily_stauts SET status_4 = 1, issues = ? WHERE patient_id = ?";

   
        }
        else if($current_time_ist >=18 && $current_time_ist <20){
            $sql = "UPDATE daily_stauts SET status_6 = 1, issues = ? WHERE patient_id = ?";

   
        }
        else{
            $response['Status'] = true;
            $response['msg'] = "Today's updates are complete. Thank you! Update again tomorrow.";
            echo json_encode($response);
        return;
        }

        $stmt = $conn->prepare($sql);
        $stmt->bind_param("is", $issues, $id);
    
   
        if ($stmt->execute()) {

            $response['Status'] = true;
            $response['msg'] = "Spigotting status updated successfully";
           
        } else {
            $response['Status'] = false;
            $response['msg'] = "Error updating record: " . $conn->error;
            
        }

    
}
else {
    $response['Status'] = false;
    $response['msg'] = "Invalid request method.";
}


echo json_encode($response);



?>