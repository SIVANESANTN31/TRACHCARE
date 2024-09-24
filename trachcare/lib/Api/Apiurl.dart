const ip = "192.168.1.10";

//login api
String PatientLoginurl ="https://$ip/Trachcare/auth/patientAuth/PatientLogin.php";
String DoctorLoginUrl = "https://$ip/Trachcare/auth/DoctorAuth/DoctorLogin.php";
String AdminLoginurl = "https://$ip/Trachcare/auth/AdminAuth/AdminLogin.php";

//video api
String videourl = "https://$ip/Trachcare/Doctor/videos.php";

//sumbit or add api
String PatientDetailsSubmitUrl = "https://$ip/Trachcare/Doctor/Addpatients.php";
String SubmitVitalsUrl = "https://$ip/Trachcare/Doctor/videos.php";
String UpdatePatientDetailsUrl = "https://$ip/Trachcare/Doctor/videos.php";
String AdddoctordetailsUrl = "https://$ip/Trachcare/Admin/Adddoctordetails.php";
String Addvideos = "https://$ip/Trachcare/Admin/addvideos.php";

//view api
String ViewPatientDetailsUrl = "https://$ip/Trachcare/Doctor/viewpatientdetails.php";
String ViewdoctordetailsUrl = "https://$ip/Trachcare/Admin/viewdoctordetails.php";
String ViewDailyVitalsUrl = "https://$ip/Trachcare/Doctor/Dailyupdates.php";
String getpatientdetialsurl = "https://$ip/Trachcare/Patient/getdetials.php";

//list api
String DoctorslistUrl = "https://$ip/Trachcare/Admin/Doctorlist.php";
String PatientslistUrl = "https://$ip/Trachcare/Doctor/Patientslist.php";

