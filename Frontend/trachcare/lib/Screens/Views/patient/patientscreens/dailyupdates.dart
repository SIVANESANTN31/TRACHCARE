
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:trachcare/Api/DataStore/Datastore.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/Appbar_copy.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../style/utils/Dimention.dart';
import '../Bottomnavigationscreens/Medication.dart';

class YourdailyReports extends StatefulWidget {
  final String name;
  final String imagePath;

  const YourdailyReports({Key? key, required this.name, required this.imagePath}) : super(key: key);

  @override
  _YourdailyReportsState createState() => _YourdailyReportsState();
}

class _YourdailyReportsState extends State<YourdailyReports> {
  final _formKey = GlobalKey<FormState>();

  // Replace with actual patient ID retrieval
  get patientId => patient_id;

  Map<String, dynamic> patientData = {
    'patient_id': patient_id, // Corresponds to patient_id in the SQL
    'respiratory_rate': '',
    'heart_rate': '',
    'spo2_room_air': '',
    'daily_dressing_done': false,
    'tracheostomy_tie_changed': false,
    'suctioning_done': false,
    'oral_feeds_started': false,
    'changed_to_green_tube': false,
    'able_to_breathe_through_nose': false,
    'secretion_color_consistency': '',
    'cough_or_breathlessness': false,
    'breath_duration': '',
    'spigotting_status': 'Not Applicable',
    
  };

  Future<void> updatePatientData() async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(SubmitVitalsUrl));

      request.headers.addAll({'Content-Type': 'multipart/form-data'});
      
      patientData.forEach((key, value) {
        if (value is bool) {
          request.fields[key] = value ? 'Yes' : 'No';
        } else {
          request.fields[key] = value.toString();
        }
      });
      print(patientData);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
      print(jsonDecode(responseBody));
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MedicationPage()),
          (route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Patient data updated successfully')),
        );
      } else {
        throw Exception('Failed to update patient data');
      }
    } catch (e) {
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
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: Duplicate_Appbar(Title: "Daily Queries", height: dn.height(20)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Namecard(widget.name, patientId, widget.imagePath, context),
              SizedBox(height: 16),
              Text('Vitals', style: TextStyle(fontWeight: FontWeight.bold)),
              buildTextField('Respiratory Rate', (value) {
                patientData['respiratory_rate'] = value;
              }, isNumber: true),
              buildTextField('Heart Rate', (value) {
                patientData['heart_rate'] = value;
              }, isNumber: true),
              buildTextField('SPO2 @ Room Air', (value) {
                patientData['spo2_room_air'] = value;
              }, isNumber: true),
              SizedBox(height: 10),
              buildYesNoQuestion('Daily dressing done?', 'daily_dressing_done'),SizedBox(height: dn.height(1)),
              buildYesNoQuestion('Tracheostomy tie changed?', 'tracheostomy_tie_changed'),SizedBox(height: dn.height(1)),
              buildYesNoQuestion('Suctioning done?', 'suctioning_done'),SizedBox(height: dn.height(1)),
              if (patientData['suctioning_done'] == true)
                buildTextField('Secretion color and consistency?', (value) {
                  patientData['secretion_color_consistency'] = value;
                }),SizedBox(height: dn.height(1)),
              buildYesNoQuestion('Has the patient started on oral feeds?', 'oral_feeds_started'),SizedBox(height: dn.height(1)),
              if (patientData['oral_feeds_started'] == true)
                buildYesNoQuestion('If Yes, experiencing cough or breathlessness?', 'cough_or_breathlessness'),SizedBox(height: dn.height(1)),
              buildYesNoQuestion('Has the patient been changed to green tube?', 'changed_to_green_tube'),SizedBox(height: dn.height(1)),
              SizedBox(height: dn.height(1)),
              buildDropdown('Spigotting status', ),
              SizedBox(height: dn.height(1)),
              buildYesNoQuestion(
                  'Is the patient able to breathe through nose while blocking the tube?',
                  'able_to_breathe_through_nose'),SizedBox(height: dn.height(1)),
              if (patientData['able_to_breathe_through_nose'] == true)
                buildTextField('If Yes, breath duration', (value) {
                  patientData['breath_duration'] = value;
                }),
              SizedBox(height: dn.height(5)),
              Center(
                child: custom_Button(
                  text: "Submit",
                  width: 50,
                  height: 6,
                  button_funcation: () => _save(context),
                  backgroundColor: const Color.fromARGB(255, 62, 195, 66),
                  textSize: 10,
                  textcolor: whiteColor,
                ),
              ),
              SizedBox(height: dn.height(10)),
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
            textInputAction: TextInputAction.next,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) return 'Please enter $labelText';
              return null;
            },
            onChanged: (value) => onChanged(value),
          ),
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
            SizedBox(width: 8),
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
      ],
    );
  }

  Widget buildDropdown(String label, ) {
    return Row(
      children: [
        Expanded(child: Text(label,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5,decoration: TextDecoration.underline),)),
       
      ],
    );
  }
}

Widget Namecard(String name, String patientId, String imagePath, BuildContext context) {
  Dimentions dn = Dimentions(context);
  return Container(
    margin: const EdgeInsets.all(10),
    width: double.infinity,
    height: dn.height(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
      border: Border.all(color: BlackColor, width: 0.3),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage("https://$ip/Trachcare/$imagePath"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  Text(
                    "Patient ID",
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(": ", style: GoogleFonts.ibmPlexSans(fontSize: 13.sp)),
                  Text(": ", style: GoogleFonts.ibmPlexSans(fontSize: 13.sp)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  Text(
                    patientId,
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
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

