import 'dart:convert';  
import 'dart:io';
import 'package:http/http.dart' as http;  
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:trachcare/Api/Apiurl.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';

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
} }

// Function to update doctor details
Future<void> updateDoctorDetails(
   BuildContext context,
  String doctorId,
  dynamic imagefile,
  String username,
  String doctorRegNo,
  String email,
  String phoneNumber,
  String password, 
) async {
  // API URL for updating doctor details
  final String apiUrl = doctordetailsUrl; // Update with your actual update URL
  try {
    if (imagefile.path.isNotEmpty) {
      // Get file extension and set appropriate MIME type
      String fileExtension = path.extension(imagefile.path).toLowerCase().replaceFirst('.', '');
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

      var request = http.MultipartRequest("PUT", Uri.parse(apiUrl)); // Use PUT for updates

      // Add fields to the request
      request.fields.addAll({
        'doctor_id' : Doctor_id,
        'username': username,
        'doctor_reg_no': doctorRegNo,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
        
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'image_data',
          imagefile.path,
          contentType: mediaType,
        ),
      );

      var response = await request.send();
print(response);
      // Handle the response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print(responseBody);
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
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong !!!")),
    );
  }
}


Future<void> updateAdminDetails(
  BuildContext context,
  String doctorId,
  File? imageFile,
  String? username,
  String? doctorRegNo,
  String? email,
  String? phoneNumber,
  String? password,
   // File type for image upload
) async {
  // Your API URL for updating doctor details
  final String apiUrl = "$admindetailsUrl?doctor_id=$doctorId";
  try {
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Add form fields only if they are not null
    request.fields['doctor_id'] = doctorId;
    if (username != null) request.fields['username'] = username;
    if (doctorRegNo != null) request.fields['doctor_reg_no'] = doctorRegNo;
    if (email != null) request.fields['email'] = email;
    if (phoneNumber != null) request.fields['phone_number'] = phoneNumber;
    if (password != null) request.fields['password'] = password;

    // If there's an image file, add it to the request
    if (imageFile != null) {
        var fileStream = http.ByteStream(imageFile!.openRead());
        var length = await imageFile!.length();
        var multipartFile = http.MultipartFile(
          'image',
          fileStream,
          length,
  
        );
        request.files.add(multipartFile);
      }
    // Send the request
    var response = await request.send();

    
   if (response.statusCode == 200) {
   var responseBody = await response.stream.bytesToString();
   print("Raw Response Body: $responseBody"); 
   var data = jsonDecode(responseBody);

      if (data['Status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
          backgroundColor: Colors.green,
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
  } catch (e) {
    // Handle errors
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('An error occurred: $e'),
    ));
  }
}
