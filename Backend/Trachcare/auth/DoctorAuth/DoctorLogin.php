<?php 
  include "../../config/conn.php";
  
  //Received JSON into $json variable
  $json = file_get_contents('php://input');
  
  //Decoding the received JSON and store into $obj variable.
  $obj = json_decode($json,true);
  
  if(isset($obj["username"]) && isset($obj["password"])){
    
    $uname = mysqli_real_escape_string($conn,$obj['username']);
    $pwd = mysqli_real_escape_string($conn,$obj['password']);
    
    //Declare array variable
    $result=[];
    
    //Select Query
    $sql="SELECT * FROM  doctorprofile WHERE email='{$uname}'AND password ='{$pwd}'";
    $res=$conn->query($sql);
    
    if($res->num_rows>0){
      
      $row = mysqli_fetch_assoc($res);
      
      $result['Status']=true;

      $result['message']="Logined sucessfully.";
     

      $result['userInfo']=$row;
      
     
    }
    
    
    else{
      
      $result['Status']=false;

      $result['message']="Invalid Login Details";

      $result['userInfo']="null";
    }
    
    
    // Converting the array into JSON format.
    $json_data=json_encode($result);
   
    
   
    // Echo the $json.
    echo $json_data;
   
  }
?>