import "dart:convert";
import "package:http/http.dart" as http;
import "package:trachcare/Api/Apiurl.dart";
import "package:trachcare/Api/DataStore/Datastore.dart";

class PatientDashBoardApi{

Future FetchDetials() async{
  var Data ={
    "patient_id":patient_id.toString()
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

Future FetchDetials() async{
   
  
  
  try {
    var url = "$doctordetailsUrl?doctor_id=$Doctor_id";
    print(url);
    final response = await http.get(Uri.parse(url));
    if(response.statusCode ==200){
      var data = jsonDecode(response.body);
        if(data['Status']){
        return data['doctorInfo'];
      }
      else{
        return data['doctorInfo'];
      }
    }
  } catch (e) {
    print(e);
    
  }
}


}


class AdminDashBoardApi{

Future FetchDetials() async{
  
  try {
    print(Doctor_id);
    var url = "$admindetailsUrl?doctor_id=$Doctor_id";
    print(url);
    final response = await http.get(Uri.parse(url));
    if(response.statusCode ==200){
      print(response.body);
      var data = jsonDecode(response.body);
      // print(data['doctorInfo']);
        if(data['Status']){
        return data['doctorInfo'];
      }
      else{
        return data['doctorInfo'];
      }
    }
  } catch (e) {
    print(e);
    
  }
}


}