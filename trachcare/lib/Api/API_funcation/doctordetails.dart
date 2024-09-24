import 'dart:convert';  // For JSON encoding/decoding
import 'dart:io';
// For handling image data
import 'package:http/http.dart' as http;  // For HTTP requests
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:trachcare/Api/Apiurl.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/Doctorlist.dart';  // For showing UI elements like alerts

// Function to add doctor details
Future<void> addDoctorDetails(
    BuildContext context,
   
    String username,
    String doctorRegNo,
    String email,
    String phoneNumber,
    String password,
    // Uint8List? imageBytes
    ) async {
  
  // API URL
  final String apiUrl = AdddoctordetailsUrl;

  // Prepare image data as base64 string if image is provided
  // String? base64Image;
  // if (imageBytes != null) {
  //   base64Image = imagefile(imageBytes);
  // }

  // Prepare request body as JSON
  final Map<String, dynamic> requestBody = {
    "username": username,
    "doctor_reg_no": doctorRegNo,
    "email": email,
    "phone_number": phoneNumber,
    "password": password, // Should hash password before sending to backend for production
   // Optional image data
  };
 
  try {
  // Send POST request to the API
  print(apiUrl);
  var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
  
  // Add fields to the request
  request.fields['username'] = requestBody['username']!;
  request.fields['email'] = requestBody['email']!;
  request.fields['phone_number'] = requestBody['phone_number']!;
  request.fields['password'] = requestBody['password']!;
  request.fields['doctor_reg_no'] = requestBody['doctor_reg_no']!;
  
  // // Add file to the request
  // request.files.add(await http.MultipartFile.fromBytes(
  //   'image_data',
  //   await File(imagefile).readAsBytes(),
  //   filename: path.basename(imagefile),
  // ));
  
  // Send the request
  var response = await request.send();
  
  // Read the response stream once
  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    print('Upload success: $responseBody');
    
    // Parse the response from the server
    var data = jsonDecode(responseBody);
    if (data['Status']) {
      // Handle success (e.g., navigate to another screen)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Doctorlist ()),
      );
      requestBody.clear();
    } else {
      // Error: Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data['message']),
        backgroundColor: Colors.red,
      ));
    }
  } else {
    // Server error
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Server error: ${response.statusCode}'),
      backgroundColor: Colors.red,
    ));
  }
} catch (e) {
  // Exception handling
  print(e);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Error: $e'),
    backgroundColor: Colors.red,
  ));
}

    }