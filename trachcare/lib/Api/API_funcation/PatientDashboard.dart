import "dart:convert";

import "package:http/http.dart" as http;
import "package:trachcare/Api/Apiurl.dart";
import "package:trachcare/Api/DataStore/Datastore.dart";

class PatientDashBoardApi{

Future FetchDetials() async{
  var Data ={
    "doctor_id":patient_id.toString()
  };
  try {
    final response = await http.post(Uri.parse(getpatientdetialsurl),body: jsonEncode(Data));
    if(response.statusCode ==200){
      var data = jsonDecode(response.body);
      if(data['Status']){
        return data['pateintinfo'];
      }
      else{
        return data['pateintinfo'];
      }
    }
  } catch (e) {
    print(e);
    
  }
}


}

class DoctorDashBoardApi{

Future FetchDetials(var doctor_id) async{
  print(doctor_id);
  
  final String url = '$ViewdoctordetailsUrl?doctor_id= ${doctor_id}';
  try {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode ==200){
      var data = jsonDecode(response.body);
        return data;
    
     
    }
  } catch (e) {
    print(e);
    
  }
}


}