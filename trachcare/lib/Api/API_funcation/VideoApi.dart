
import 'dart:convert';

import '../Apiurl.dart';
import 'package:http/http.dart'as http;

class Video{
Future Fetchvideo(String patient_id,String doctorid)async{
try {
    final response  =  await http.get(Uri.parse("$videourl?patient_id=$patient_id&doctorid=$doctorid"));
    if(response.statusCode ==200){
        var data = jsonDecode(response.body);
        if(data["status"]){
          return data["data"][0]["Video_url"].toString().split("/n/").toList();

        }}
  
} catch (e) {
  
}

}
}