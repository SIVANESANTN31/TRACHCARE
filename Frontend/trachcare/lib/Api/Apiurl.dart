const ip = "172.20.10.9";

//login api
String PatientLoginurl ="https://$ip/Trachcare/auth/patientAuth/PatientLogin.php";
String DoctorLoginUrl = "https://$ip/Trachcare/auth/DoctorAuth/DoctorLogin.php";
String AdminLoginurl = "https://$ip/Trachcare/auth/AdminAuth/AdminLogin.php";


//sumbit or add api
String PatientDetailsSubmitUrl = "https://$ip/Trachcare/Doctor/Addpatients.php";
String SubmitVitalsUrl = "https://$ip/Trachcare/Patient/adddailyupdates.php";
String UpdatePatientDetailsUrl = "https://$ip/Trachcare/Doctor/videos.php";
String AdddoctordetailsUrl = "https://$ip/Trachcare/Admin/Adddoctordetails.php";

//view api
String ViewPatientDetailsUrl = "https://$ip/Trachcare/Doctor/viewpatientdetails.php";
String doctordetailsUrl = "https://$ip/Trachcare/Admin/doctordetails.php";
String admindetailsUrl = "https://$ip/Trachcare/Admin/admindetails.php";
String ViewDailyVitalsUrl = "https://$ip/Trachcare/Doctor/Dailyupdates.php";
String getpatientdetialsurl = "https://$ip/Trachcare/Patient/getdetials.php";

//list api
String DoctorslistUrl = "https://$ip/Trachcare/Admin/Doctorlist.php";
String PatientslistUrl = "https://$ip/Trachcare/Doctor/Patientslist.php";
String allpatientslistUrl = "https://$ip/Trachcare/Admin/patientlist.php";

//update api
String UpdateDoctorDetailsUrl = "https://$ip/Trachcare/Doctor/Addpatients.php";

//video api
String Addvideos = "https://$ip/Trachcare/Admin/addvideos.php";