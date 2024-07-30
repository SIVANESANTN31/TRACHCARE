import "dart:convert";

import "package:http/http.dart" as http;
import "package:trachcare/Api/Apiurl.dart";
import "package:trachcare/Api/DataStore/Datastore.dart";

class PatientDashBoardApi{

Future FetchDetials() async{
  var Data ={
    "id":patient_id.toString()
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