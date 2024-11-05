import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';
import '../../patient/Bottomnavigationscreens/Medication.dart';

class Viewdailyupdates extends StatefulWidget {
   final String name;
  final String imagePath;
  final String selecteddate;
  final String patientId; // Assuming patientId is passed in as well

  Viewdailyupdates({super.key,required this.name, required this.imagePath, required this.selecteddate, required this.patientId});

  @override
  _ViewdailyupdatesState createState() => _ViewdailyupdatesState();
}

class _ViewdailyupdatesState extends State<Viewdailyupdates> {
  final _formKey = GlobalKey<FormState>();

  // Replace with actual patient ID retrieval
  get patientId => patient_id;
  var patientData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatientData();
  }
  Future<void> fetchPatientData() async {
  setState(() {
    isLoading = true; // Show loading indicator
  });

  final url = Uri.parse('$ViewDailyVitalsUrl?patient_id=${widget.patientId}&date=${widget.selecteddate}'); // Replace with your actual API URL

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON data from the response
      var data = jsonDecode(response.body);

      
      setState(() {
        patientData = data['patient_details'][0]; 
        print(patientData['patient_id']);// Update the patient data with the fetched data
        isLoading = false; // Hide loading indicator
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false; // Hide loading indicator
      });
      throw Exception('Failed to load patient data');
    }
  } catch (error) {
    setState(() {
      isLoading = false; // Hide loading indicator
    });
    print('Error fetching patient data: $error');
  }
}



  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: 
NormalAppbar(
        Title: "Doctors List",
        height: dn.height(10),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MedicationPage(),
            ),
          );
        },
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                value= patientData['respiratory_rate'] ;
              }, isNumber: true),
              buildTextField('Heart Rate', (value) {
                patientData['heart_rate'] = value;
              }, isNumber: true),
              buildTextField('SPO2 @ Room Air', (value) {
                patientData['spo2_room_air'] = value;
              }, isNumber: true),
              SizedBox(height: 10),
              buildYesNoQuestion('Daily dressing done?', 'daily_dressing_done'),
              buildYesNoQuestion('Tracheostomy tie changed?', 'tracheostomy_tie_changed'),
              buildYesNoQuestion('Suctioning done?', 'suctioning_done'),
              if (patientData['suctioning_done'] == true)
                buildTextField('Secretion color and consistency?', (value) {
                  patientData['secretion_color_consistency'] = value;
                }),
              buildYesNoQuestion('Has the patient started on oral feeds?', 'oral_feeds_started'),
              if (patientData['oral_feeds_started'] == true)
                buildYesNoQuestion('If Yes, experiencing cough or breathlessness?', 'cough_or_breathlessness'),
              buildYesNoQuestion('Has the patient been changed to green tube?', 'changed_to_green_tube'),
              buildDropdown('Spigotting status', 'spigotting_status', ['Not Applicable', 'Option 1', 'Option 2']),
              buildYesNoQuestion(
                  'Is the patient able to breathe through nose while blocking the tube?',
                  'able_to_breathe_through_nose'),
              if (patientData['able_to_breathe_through_nose'] == true)
                buildTextField('If Yes, breath duration', (value) {
                  patientData['breath_duration'] = value;
                }),
              SizedBox(height: 20),
               ElevatedButton(
                    onPressed: () {
                      // Implement update logic if needed
                    },
                    child: Text('Update Patient Data'),
                  ),
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

Widget Namecard(String name, String patientId, String imagePath, BuildContext context) {
  Dimentions dn = Dimentions(context);
  return Container(
    margin: const EdgeInsets.all(10),
    width: double.infinity,
    height: dn.height(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
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
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  Text(
                    "Patient Id ",
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    ":",
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  Text(
                    ": ",
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                ],
              ),
              Column(
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
}