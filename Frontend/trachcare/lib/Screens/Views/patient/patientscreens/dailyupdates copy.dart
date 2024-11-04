import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/Appbar_copy.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../../style/utils/Dimention.dart';
import '../Bottomnavigationscreens/Medication.dart';

class YourdailyReports extends StatefulWidget {
  const YourdailyReports({super.key});

  @override
  _YourdailyReportsState createState() => _YourdailyReportsState();
}

class _YourdailyReportsState extends State<YourdailyReports> {

  final _formKey = GlobalKey<FormState>();
  
Map<String, dynamic> patientData = {
  'patient_id': patient_id, // Corresponds to patient_id in the SQL
  'respiratory_rate': '', // Corresponds to respiratory_rate in the SQL
  'heart_rate': '', // Corresponds to heart_rate in the SQL
  'spo2_room_air': '', // Changed from 'spo2' to 'spo2_room_air'
  'daily_dressing_done': false, // Corresponds to daily_dressing_done in the SQL
  'tracheostomy_tie_changed': false, // Corresponds to tracheostomy_tie_changed in the SQL
  'suctioning_done': false, // Corresponds to suctioning_done in the SQL
  'oral_feeds_started': false, // Changed from 'started_on_oral_feeds' to 'oral_feeds_started'
  'changed_to_green_tube': false, // Corresponds to changed_to_green_tube in the SQL
  'able_to_breathe_through_nose': false, // Changed from 'able_to_breathe' to 'able_to_breathe_through_nose'
  'secretion_color_consistency': '', // Corresponds to secretion_color_consistency in the SQL
  'cough_or_breathlessness': false, // Changed from 'cough_or_breathlessness' to boolean to align with yes/no question
  'breath_duration': '', // Changed from 'breathing_duration' to 'breath_duration'
  'image_path': '', // Add image path if applicable
};
Future<void> updatePatientData() async {
  try {
    // Create a MultipartRequest for 'POST' with the URL
    var request = http.MultipartRequest('POST', Uri.parse(SubmitVitalsUrl));

    // Add headers if needed
    request.headers.addAll({'Content-Type': 'multipart/form-data'});

    // Prepare the form data with string values
    Map<String, String> formData = {};
    patientData.forEach((key, value) {
      if (value is bool) {
        formData[key] = value ? 'Yes' : 'No'; // Convert bool to Yes/No
      } else {
        formData[key] = value.toString(); // Convert other types to string
      }
    });

    // Add each field from the formData map as form data
    formData.forEach((key, value) {
      request.fields[key] = value;
    });

    var response = await request.send();

    // Get the response body for status and error checking
    var responseBody = await response.stream.bytesToString();
    print(response.statusCode);
    print(responseBody);

    if (response.statusCode == 200) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => MedicationPage(),
          ),(route)=>false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Patient data updated successfully')),
      );
    } else {
      throw Exception('Failed to update patient data');
    }
  } catch (e) {
    print('Error updating patient data: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to update patient data')),
    );
  }
}

  void _save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      updatePatientData();
      _formKey.currentState!.reset();
    }
  }

// Update the relevant form fields to reflect these changes
@override
Widget build(BuildContext context) {
  Dimentions dn = Dimentions(context);
  return Scaffold(
    appBar: Duplicate_Appbar(Title: "Patient List", height: dn.height(20)),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NameCard("siva", patient_id),
            SizedBox(height: 16),
            Text('Vitals', style: TextStyle(fontWeight: FontWeight.bold)),
            
            // Update text fields to match the SQL fields
            buildTextField('Respiratory Rate', (value) {
              patientData['respiratory_rate'] = value;
            }, isNumber: true),
            
            buildTextField('Heart Rate', (value) {
              patientData['heart_rate'] = value;
            }, isNumber: true),
            
            buildTextField('SPO2 @ Room Air', (value) {
              patientData['spo2_room_air'] = value; // Update key to match SQL
            }, isNumber: true),
            SizedBox(height: 10),
            
            buildYesNoQuestion('Daily dressing done?', 'daily_dressing_done'), 
            SizedBox(height: 10),
            
            buildYesNoQuestion('Tracheostomy tie changed?', 'tracheostomy_tie_changed'),
            SizedBox(height: 10),
            
            buildYesNoQuestion('Suctioning done?', 'suctioning_done'), 
            SizedBox(height: 10),
            
            if (patientData['suctioning_done'] == true)
              buildTextField('If Yes, What is the colour and consistency Secretions?', (value) {
                patientData['secretion_color_consistency'] = value; // Update key to match SQL
              }), 
            SizedBox(height: 10),
            
            buildYesNoQuestion('Has the patient started on oral feeds?', 'oral_feeds_started'), // Update key
            SizedBox(height: 10),
            
            if (patientData['oral_feeds_started'] == true)
              buildYesNoQuestion('If Yes, Is He Experiencing Cough or Breathlessness', 'cough_or_breathlessness'), 
            SizedBox(height: 10),
            
            buildYesNoQuestion('Has the patient been changed to green tube?', 'changed_to_green_tube'),
            SizedBox(height: 10),
            
            buildDropdown('Spigotting status', 'spigotting_status', ['Not Applicable', 'Option 1', 'Option 2']),
            buildYesNoQuestion('Is the patient able to breathe through nose, while blocking the tube with hands?', 'able_to_breathe_through_nose'), // Update key
            SizedBox(height: 10),
            
            if (patientData['able_to_breathe_through_nose'] == true)
              buildTextField('If Yes, How long the patient can able to breath?', (value) {
                patientData['breath_duration'] = value; // Update key to match SQL
              }),
            SizedBox(height: 40),
            
            Center(
              child: custom_Button(
                text: "Submit",
                width: 50,
                height: 6,
                button_funcation: () => _save(context),
                backgroundColor: const Color.fromARGB(255, 62, 195, 66),
                textSize: 10, textcolor: whiteColor,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}



  Widget buildTextField(String labelText, Function(String) onChanged, {bool isNumber = false}) {
    return Row(
      children: [
        Expanded(child: Text(labelText)),
        SizedBox(
          width: 100,
          child: TextFormField(
      
      
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          onChanged(value);
        });
      },
    )
        ),
      ],
    );
  }
 
Widget buildYesNoQuestion(String question, String key) {
  return Row(
    children: [
      Expanded(child: Text(question)),
      Row(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                patientData[key] = true;
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: patientData[key] == true ? Colors.blue : Colors.grey[300],
            ),
            child: Text(
              "Yes",
              style: TextStyle(
                color: patientData[key] == true ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {
              setState(() {
                patientData[key] = false;
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: patientData[key] == false ? Colors.blue : Colors.grey[300],
            ),
            child: Text(
              "No",
              style: TextStyle(
                color: patientData[key] == false ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
      // SizedBox(height: 10,)
    ],
    
  );
  
}

  Widget buildDropdown(String label, String key, List<String> options) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        DropdownButton<String>(
          value: patientData[key] ?? options.first,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                patientData[key] = newValue;
              });
            }
          },
        ),
      ],
    );
  }
}



Widget NameCard(String name, String patientId) {
  return Container(
    margin: const EdgeInsets.all(8),
    width: double.infinity,
    height: 15.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: BlackColor, width: 0.3),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CircleAvatar(
          minRadius: 20,
          child: Image(image: AssetImage("assets/images/doctor.png")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Name :",
                    style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 10.sp)),
                  ),
                  Text(
                    "Patient Id :",
                    style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 10.sp)),
                  ),
                ],
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Text(
              //       ":",
              //       style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 13.sp)),
              //     ),
              //     Text(
              //       ":",
              //       style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 13.sp)),
              //     ),
              //   ],
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 13.sp)),
                  ),
                  Text(
                    patientId,
                    style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 13.sp)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
