<?php

include '../config/conn.php';

$json = file_get_contents('php://input');
$obj = json_decode($json,true);

if(isset($obj["doctor_id"])){
    $id = mysqli_real_escape_string($conn,$obj['doctor_id']);

    $result=[];

    $sql="SELECT * FROM  patientdetials  WHERE patient_id='{$doctor_id}'";
    $res=$conn->query($sql);


    if($res->num_rows>0){
      $row = $res->fetch_assoc();
        
        
        $result['Status']=true;
        $result['message']="Successfully the id retrived from the database.";
        
        $result["pateintinfo"]=$row;
        
      }else{
        
        $result['Status']=false;
        $result['message']="failed to retrieve the id from the database";
        $result['userInfo']="failed to retrieve the id from the database";
      }
     
     $json_data=json_encode($result);
      
     echo $json_data;
}




?>