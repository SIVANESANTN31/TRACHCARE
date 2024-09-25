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

    
var request = http.MultipartRequest("POST", Uri.parse(apiUrl));

    // Add fields to the request
    request.fields.addAll({
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
      'doctor_reg_no': doctorRegNo,
    });

request.files.add(
        await http.MultipartFile.fromPath(
          'image_data',
          imagefile.path,
          contentType: mediaType,
        ),
      );

var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      print(data['Status']);
      if (data['Status']) {

         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['msg']),
          backgroundColor: Colors.green[400],
        ));

        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Server error: ${response.statusCode}'),
        backgroundColor: Colors.red,
      ));
  }
  
}

    




}catch(e){
ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went worng !!!")),
      );
}

    }