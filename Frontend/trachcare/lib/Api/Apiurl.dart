const ip = "180.235.121.245"; 
// const ip = "172.20.10.4"; 

//login apikfl;djbl;
String PatientLoginurl ="https://$ip/Trachcare/auth/patientAuth/PatientLogin.php";
String DoctorLoginUrl = "https://$ip/Trachcare/auth/DoctorAuth/DoctorLogin.php";
String AdminLoginurl = "https://$ip/Trachcare/auth/AdminAuth/AdminLogin.php";


//sumbit or add api
String PatientDetailsSubmitUrl = "https://$ip/Trachcare/Doctor/Addpatients.php";
String SubmitVitalsUrl = "https://$ip/Trachcare/Patient/adddailyupdates.php";
String UpdatePatientDetailsUrl = "https://$ip/Trachcare/Patient/editpatientprofile.php";
String AdddoctordetailsUrl = "https://$ip/Trachcare/Admin/Adddoctordetails.php";

//view api
String viewstory = "https://$ip/Trachcare/Doctor/viewstory.php";
String dailyreport= "https://$ip/Trachcare/Patient/dailyreport.php";
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
String exporturl = "https://$ip/Trachcare/Admin/export.php";
String statusurl = "https://$ip/Trachcare/Doctor/status.php";
String statusurlpatient = "https://$ip/Trachcare/Patient/status.php";
String updatestatusurl = "https://$ip/Trachcare/Doctor/updatestatus.php";
String updatestatusspogotingurl = "https://$ip/Trachcare/Doctor/spogoting_status.php";
