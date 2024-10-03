
import 'dart:convert';

import '../Apiurl.dart';
import 'package:http/http.dart'as http;

class Video{
Future Fetchvideo()async{
try {
    final response  =  await http.get(Uri.parse("$Addvideos"));
    if(response.statusCode ==200){
        var data = jsonDecode(response.body);
        if(data["status"]){
          return data["data"];

        }
        else{
          return data["data"];
        }}
  
} catch (e) {
  
}

}
}