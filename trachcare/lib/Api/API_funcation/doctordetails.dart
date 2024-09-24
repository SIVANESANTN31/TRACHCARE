import 'dart:convert';  // For JSON encoding/decoding
import 'dart:io';
// For handling image data
import 'package:http/http.dart' as http;  // For HTTP requests
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:trachcare/Api/Apiurl.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/Doctorlist.dart'; 
import  'package:dio/dio.dart'; // For showing UI elements like alerts

// Function to add doctor details
Future<void> addDoctorDetails(
    BuildContext context,
   File imagefile,
    String username,
    String doctorRegNo,
    String email,
    String phoneNumber,
    String password,
    // Uint8List? imageBytes
    ) async {
  
  // API URL
  final String apiUrl = AdddoctordetailsUrl;

  final dio = Dio();

try{


  

if (imagefile.path.isNotEmpty) {
      // Get file extension and set appropriate MIME type
      String fileExtension = path.extension(imagefile.path).toLowerCase().replaceFirst('.', '');
      
      // Map the extension to the appropriate media type
      MediaType mediaType;
      switch (fileExtension) {
        case 'jpg':
         mediaType = MediaType('image', 'jpg');
          break;
        case 'jpeg':
          mediaType = MediaType('image', 'jpeg');
          break;
        case 'png':
          mediaType = MediaType('image', 'png');
          break;
        case 'gif':
          mediaType = MediaType('image', 'gif');
          break;
        default:
          throw Exception('Unsupported image format');
      }

      // Add the file to the request
    final RequestData = FormData.fromMap({
  "username": username,
  "email": email,
  "phone_number": phoneNumber,
  "password": password,
  "doctor_reg_no":doctorRegNo,
  "image_data":await MultipartFile.fromFile(imagefile.path,contentType: mediaType)
});
final response = await dio.post(apiUrl,data: RequestData);

if(response.statusCode==200){
  var data = response.data;
  print(data.runtimeType);
  if(data){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["msg"])),
      );
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Doctorlist ()),
      );
  }
  else{
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["msg"])),
      );

  }
}

    
}



}catch(e){
ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went worng !!!")),
      );
}

    }