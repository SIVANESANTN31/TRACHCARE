<?php

include '../config/conn.php';


$obj = json_decode($json,true);

if(isset($_GET['doctor_id'])){
    $id = mysqli_real_escape_string($conn,$_GET['doctor_id']);

    $result=[];

    $sql="SELECT * FROM  doctorprofile  WHERE doctor_id='{$id}'";
    $res=$conn->query($sql);


    if($res->num_rows>0){

      $row = $res->fetch_assoc();
        
        
        $result['Status']=true;
        $result['message']="Successfully the id retrived from the database.";
        
        $result["doctorInfo"]=$row;
        
      }else{
        
        $result['Status']=false;
        $result['message']="failed to retrieve the id from the database";
        $result['doctorInfo']="failed to retrieve the id from the database";
      }
     
     $json_data=json_encode($result);
      
     echo $json_data;
}




?>