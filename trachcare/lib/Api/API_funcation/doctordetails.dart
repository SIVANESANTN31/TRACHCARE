import 'dart:convert';  // For JSON encoding/decoding
// For handling image data
import 'package:http/http.dart' as http;  // For HTTP requests
import 'package:flutter/material.dart';
import 'package:trachcare/Api/Apiurl.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/Doctorlist.dart';  // For showing UI elements like alerts

// Function to add doctor details
Future<void> addDoctorDetails(
    BuildContext context,
    String base64Encode,
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
  //   base64Image = base64Encode(imageBytes);
  // }

  // Prepare request body as JSON
  final Map<String, dynamic> requestBody = {
    "username": username,
    "doctor_reg_no": doctorRegNo,
    "email": email,
    "phone_number": phoneNumber,
    "password": password, // Should hash password before sending to backend for production
    "image_data": base64Encode // Optional image data
  };

  try {
    // Send POST request to the API
    print(apiUrl);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );
    print(response.body);

    if (response.statusCode == 200) {
      // Parse the response from the server
      var data = jsonDecode(response.body);

      if (data['Status']) {
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Doctorlist()));
    requestBody.clear();
        // Success: Show a success dialog or message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Doctor added successfully.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
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
    print("ethu than athu");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error: $e'),
      backgroundColor: Colors.red,
    ));
  }
}
