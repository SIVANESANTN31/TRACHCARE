<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "trachcare";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
 
// Check connection
if ($conn->connect_error) {
   
    die("Connection failed: " );
    
}
else{
   //echo json_encode("Connection established");
}
?>