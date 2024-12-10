import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:trachcare/Api/Apiurl.dart';
import "package:http/http.dart" as http;

import '../../Screens/Views/Doctor/Bottomnavigator/patientslist.dart';


Future<void> addPatientDetails(
  BuildContext context,
  File imagefile,
  String doctorId,
  String username,
  String email,
  String phoneNumber,
  String password,
  String age,
  String gender,
  String address,
  String appoinment,
  String bmi,
  String diagnosis,
  String surgeryStatus,
  String postOpTracheostomyDay,
  String tubeNameSize,
  String baselineVitals,
  String respiratoryRate,
  String heartRate,
  String spo2RoomAir,
  String indicationOfTracheostomy,
  String comorbidities,
  String hemoglobin,
  String srSodium,
  String srPotassium,
  String srCalcium,
  String srBicarbonate,
  String pt,
  String aptt,
  String inr,
  String platelets,
  String liverFunctionTest,
  String renalFunctionTest,
) async {
  // API URL
  final String apiUrl = PatientDetailsSubmitUrl;

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
        
        default:
          throw Exception('Unsupported image format');
      }

      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));

      // Add fields to the request
      request.fields.addAll({
        'doctor_id': doctorId,
        'username': username,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
        'age': age,
        'gender': gender,
        'address': address,
        'bmi': bmi,
        'appoinment': appoinment,
        'diagnosis': diagnosis,
        'surgery_status': surgeryStatus,
        'post_op_tracheostomy_day': postOpTracheostomyDay,
        'tube_name_size': tubeNameSize,
        'baseline_vitals': baselineVitals,
        'respiratory_rate': respiratoryRate,
        'heart_rate': heartRate,
        'spo2_room_air': spo2RoomAir,
        'indication_of_tracheostomy': indicationOfTracheostomy,
        'comorbidities': comorbidities,
        'hemoglobin': hemoglobin,
        'sr_sodium': srSodium,
        'sr_potassium': srPotassium,
        'sr_calcium': srCalcium,
        'sr_bicarbonate': srBicarbonate,
        'pt': pt,
        'aptt': aptt,
        'inr': inr,
        'platelets': platelets,
        'liver_function_test': liverFunctionTest,
        'renal_function_test': renalFunctionTest,
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'image_path',
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
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong !!!"+e.toString() )),
    );
  }
}

void UpdatePatientDetails(BuildContext context, String patientId,
    Map<String, dynamic> updatedDetails) async {
  try {
    final response = await http.put(
      Uri.parse(
          UpdatePatientDetailsUrl), // Assuming you pass patientId in the URL
      body: jsonEncode(updatedDetails),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["Status"]) {
        print(data);
        toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('${data['message']} 🎉'),
          showProgressBar: false,
          icon: const Icon(Icons.check_circle_outline, color: Colors.green),
          showIcon: true,
          autoCloseDuration: const Duration(seconds: 2),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const patientslist()),
        );
      } else {
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('${data['message']}'),
          icon: const Icon(Icons.cancel_rounded, color: Colors.red),
          showIcon: true,
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    }
  } catch (e) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      context: context,
      title: const Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(Icons.cancel_rounded, color: Colors.red),
      showIcon: true,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}

void ViewPatientDetails(BuildContext context, String patientId) async {
  try {
    final response = await http.get(
      Uri.parse(
          ViewPatientDetailsUrl), // Assuming you pass patientId in the URL
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["Status"]) {
        print(data);
        // Display patient details (example using a dialog or new screen)
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Patient Details'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Name: ${data['userInfo']['name']}'),
                    Text('Age: ${data['userInfo']['age']}'),
                    Text('Address: ${data['userInfo']['address']}'),
                    Text('BMI: ${data['userInfo']['bmi']}'),
                    Text('Diagnosis: ${data['userInfo']['diagnosis']}'),
                    Text(
                        'Surgery Status: ${data['userInfo']['surgery_status']}'),
                    Text(
                        'Post-op Tracheostomy Day: ${data['userInfo']['post_op_tracheostomy_day']}'),
                    Text(
                        'Tube Name and Size: ${data['userInfo']['tube_name_and_size']}'),
                    const Text('Baseline Vitals:'),
                    Text(
                        ' - Respiratory Rate: ${data['userInfo']['baseline_vitals']['respiratory_rate']}'),
                    Text(
                        ' - Heart Rate: ${data['userInfo']['baseline_vitals']['heart_rate']}'),
                    Text(
                        ' - SPO2 @ Room Air: ${data['userInfo']['baseline_vitals']['spo2_room_air']}'),
                    Text(
                        'Indication of Tracheostomy: ${data['userInfo']['indication_of_tracheostomy']}'),
                    Text('Comorbidities: ${data['userInfo']['comorbidities']}'),
                    Text('Hemoglobin: ${data['userInfo']['hemoglobin']}'),
                    Text('Sr. Sodium: ${data['userInfo']['sr_sodium']}'),
                    Text('Sr. Potassium: ${data['userInfo']['sr_potassium']}'),
                    Text('Sr. Calcium: ${data['userInfo']['sr_calcium']}'),
                    Text(
                        'Sr. Bicarbonate: ${data['userInfo']['sr_bicarbonate']}'),
                    Text('APTT: ${data['userInfo']['aptt']}'),
                    Text('INR: ${data['userInfo']['inr']}'),
                    Text('Platelets: ${data['userInfo']['platelets']}'),
                    Text(
                        'Liver Function Test: ${data['userInfo']['liver_function_test']}'),
                    Text(
                        'Renal Function Test: ${data['userInfo']['renal_function_test']}'),
                    Text('Medications: ${data['userInfo']['medications']}'),
                    Text(
                        'Next Appointment: ${data['userInfo']['next_appointment']}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('${data['message']}'),
          icon: const Icon(Icons.cancel_rounded, color: Colors.red),
          showIcon: true,
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    }
  } catch (e) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      context: context,
      title: const Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(Icons.cancel_rounded, color: Colors.red),
      showIcon: true,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}


