import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/colors.dart';
import 'package:sizer/sizer.dart';

class YourdailyReports extends StatefulWidget {
  const YourdailyReports({super.key});

  @override
  _YourdailyReportsState createState() => _YourdailyReportsState();
}

class _YourdailyReportsState extends State<YourdailyReports> {

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> patientData = { // You can initialize this with your patient data
    'patient_id': patient_id,
    'respiratory_rate': '',
    'heart_rate': '',
    'spo2': '',
    'daily_dressing_done': false,
    'tracheostomy_tie_changed': false,
    'suctioning_done': false,
    'started_on_oral_feeds': false,
    'changed_to_green_tube': false,
    'spigotting_status': 'Not Applicable',
    'able_to_breathe': false,
    'breathing_duration': '',
  };

  Future<void> updatePatientData() async {
    try {
      final response = await http.post(
        Uri.parse(SubmitVitalsUrl),
        body: json.encode(patientData),
        headers: {'Content-Type': 'application/json'},
      );

      print(response.statusCode);
    print(response.body);

      if (response.statusCode == 200) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Vitals Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              NameCard("siva",patient_id),
              SizedBox(height: 16),
              Text('Vitals', style: TextStyle(fontWeight: FontWeight.bold)),
              buildTextField('Respiratory Rate', (value) {patientData['respiratory_rate'] = value;}, isNumber: true),
              buildTextField('Heart Rate', (value) {patientData['heart_rate'] = value;}, isNumber: true),
              buildTextField('SPO2 @ Room Air', (value) {patientData['spo2'] = value;}, isNumber: true),
              buildYesNoQuestion('Daily dressing done?', 'daily_dressing_done'),
              buildYesNoQuestion('Tracheostomy tie changed?', 'tracheostomy_tie_changed'),
              buildYesNoQuestion('Suctioning done?', 'suctioning_done'),
              buildYesNoQuestion('Has the patient started on oral feeds?', 'started_on_oral_feeds'),
              buildYesNoQuestion('Has the patient been changed to green tube?', 'changed_to_green_tube'),
              buildDropdown('Spigotting status', 'spigotting_status', ['Not Applicable', 'Option 1', 'Option 2']),
              buildYesNoQuestion('Is the patient able to breathe through nose, while blocking the tube with hands?', 'able_to_breathe'),
              if (patientData['able_to_breathe'] == true)
                buildTextField('If Yes, How long the patient can able to breath?', (value) {
                  patientData['breathing_duration'] = value;
                }),
              SizedBox(height: 40),
              Center(
                child: custom_Button(
                  text: "Submit",
                  width: 50,
                  height: 6,
                  button_funcation: () => _save(context),
                  backgroundColor: const Color.fromARGB(255, 62, 195, 66),
                  textSize: 13, textcolor: whiteColor,
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
  // Widget buildTextField(String labelText, Function(String) onChanged, {bool isNumber = false}) {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: labelText),
  //     keyboardType: isNumber ? TextInputType.number : TextInputType.text,
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         return 'Please enter $labelText';
  //       }
  //       return null;
  //     },
  //     onChanged: (value) {
  //       setState(() {
  //         onChanged(value);
  //       });
  //     },
  //   );
  // }

  Widget buildYesNoQuestion(String question, String key) {
    return Row(
      children: [
        Expanded(child: Text(question)),
        Switch(
          value: patientData[key] ?? false,
          onChanged: (value) {
            setState(() {
              patientData[key] = value;
            });
          },
        ),
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
    margin: const EdgeInsets.all(10),
    width: double.infinity,
    height: 12.h,
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
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 13.sp)),
                  ),
                  Text(
                    "Patient Id",
                    style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 13.sp)),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    ":",
                    style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 13.sp)),
                  ),
                  Text(
                    ":",
                    style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 13.sp)),
                  ),
                ],
              ),
              Column(
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
