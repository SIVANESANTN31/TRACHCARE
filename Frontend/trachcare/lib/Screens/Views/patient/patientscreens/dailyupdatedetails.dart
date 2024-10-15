import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../components/Appbar_copy.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';

class Viewdailyupdates extends StatefulWidget {
    final String  selecteddate ;
    
  Viewdailyupdates({super.key, required this.selecteddate});
  // final String patientId = patient_id;
  
  // final String date = selectedDate;
  // final selectedDate;
  
  @override
  _ViewdailyupdatesState createState() => _ViewdailyupdatesState();
  
}

class _ViewdailyupdatesState extends State<Viewdailyupdates> {
  Map<String, dynamic> patientData = {};
  bool isLoading = true;
  
  Object? get selectedDate => selectedDate;

  @override
  void initState() {
    super.initState();
    fetchPatientData();
  }

  Future<void> fetchPatientData() async {
    print(selectedDate);
    final String url = '$ViewPatientDetailsUrl?patient_id=${patient_id }&date=${selectedDate}';
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        setState(() {
          patientData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load patient data');
      }
    } catch (e) {
      print('Error fetching patient data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updatePatientData() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api/update_patient_vitals.php'),
        body: json.encode(patientData),
        headers: {'Content-Type': 'application/json'},
      );

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

  @override
  Widget build(BuildContext context) {
    print(selectedDate);
     Dimentions dn = Dimentions(context);
    return Scaffold(
      
      
      appBar: Duplicate_Appbar(
        Title: "Doctors List",height: dn.height(10), 
      ),
      body:  SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  
                  Center(child: Text('Date: ${widget.selecteddate}', style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(height: 16),
                  Namecard('siva', '45614 ',context),     
                  SizedBox(height: 16),
                  Text('Vitals', style: TextStyle(fontWeight: FontWeight.bold)),
                  _buildNumberInput('Respiratory Rate', 'respiratory_rate'),
                  _buildNumberInput('Heart Rate', 'heart_rate'),
                  _buildNumberInput('SPO2 @ Room Air', 'spo2'),
                  _buildYesNoQuestion('Daily dressing done?', 'daily_dressing_done'),
                  _buildYesNoQuestion('Tracheostomy tie changed?', 'tracheostomy_tie_changed'),
                  _buildYesNoQuestion('Suctioning done?', 'suctioning_done'),
                  _buildYesNoQuestion('Has the patient started on oral feeds?', 'started_on_oral_feeds'),
                  _buildYesNoQuestion('Has the patient been changed to green tube?', 'changed_to_green_tube'),
                  _buildDropdown('Spigotting status', 'spigotting_status', ['Not Applicable', 'Option 1', 'Option 2']),
                  _buildYesNoQuestion('Is the patient able to breathe through nose, while blocking the tube with hands?', 'able_to_breathe'),
                  if (patientData['able_to_breathe'] == true)
                    _buildTextInput('If Yes, How long the patient can able to breath?', 'breathing_duration'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text('Update Patient Data'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildNumberInput(String label, String key) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: patientData[key]?.toString() ?? '',
            keyboardType: TextInputType.number,
            onChanged: (text) {
              setState(() {
                patientData[key] = int.tryParse(text) ?? patientData[key];
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildYesNoQuestion(String question, String key) {
    return Row(
      children: [
        Expanded(child: Text(question)),
        Switch(
          value: patientData[key] ?? true,
          onChanged: (value) {
            setState(() {
              patientData[key] = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String key, List<String> options) {
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

  Widget _buildTextInput(String label, String key) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: patientData[key] ?? '',
            onChanged: (text) {
              setState(() {
                patientData[key] = text;
              });
            },
          ),
        ),
      ],
    );
  }
}



Widget Namecard(String name, String patientId,BuildContext context) {
  Dimentions dn = Dimentions(context);
  return Container(
    margin: const EdgeInsets.all(10),
    width: double.infinity,
    height: dn.height(15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: BlackColor, width: 0.3)),
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
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    ),
                    Text(
                      "Patient Id ",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      ":",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    ),
                    Text(
                      ": ",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    ),
                    Text(
                      patientId,
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    )
                  ],
                )
              ],
            ))
      ],
    ),
  );
}