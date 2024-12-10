import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/Doctor/Doctormainscreen.dart';
// import 'package:trachcare/Api/DataStore/Datastore.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';


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
        print(patientData['daily_dressing_done']);// Update the patient data with the fetched data
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: 
      NormalAppbar(
          Title: "Dialy updates Reports",
          height: dn.height(10),
          onTap: () {
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) => Doctormainpage(),),(route)=>false);
        },
        ),
         body: isLoading
          ? Center(child: CircularProgressIndicator())
          : patientData['respiratory_rate']== null
              ? Center(
        child:
            const Text("No data available in this date!!"),
       
      )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Namecard(widget.name, widget.patientId, widget.imagePath, context),
                        SizedBox(height: 16),
                        Text('Vitals', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline, fontSize: 16.5)),
                        buildTextField('Respiratory Rate', (value) {
                          value = patientData['respiratory_rate'];
                        }, patientData['respiratory_rate'], isNumber: true),SizedBox(height: dn.height(1)),
                        buildTextField('Heart Rate', (value) {
                          patientData['heart_rate'] = value;
                        }, patientData['heart_rate'], isNumber: true),SizedBox(height: dn.height(1)),
                        buildTextField('SPO2 @ Room Air', (value) {
                          patientData['spo2_room_air'] = value;
                        }, patientData['spo2_room_air'], isNumber: true),SizedBox(height: dn.height(1)),
                        
                        buildYesNoQuestion('Daily dressing done?', 'daily_dressing_done'),SizedBox(height: dn.height(1)),
                        buildYesNoQuestion('Tracheostomy tie changed?', 'tracheostomy_tie_changed'),SizedBox(height: dn.height(1)),
                        buildYesNoQuestion('Suctioning done?', 'suctioning_done'),SizedBox(height: dn.height(1)),
                        if (patientData['suctioning_done'] == "Yes")
                          buildTextField('Secretion color and consistency?', (value) {
                            patientData['secretion_color_consistency'] = value;
                          }, patientData['secretion_color_consistency']),SizedBox(height: dn.height(1)),
                        buildYesNoQuestion('Has the patient started on oral feeds?', 'oral_feeds_started'),
                        SizedBox(height: dn.height(1)),
                        if (patientData['oral_feeds_started'] == 'Yes')
                          buildYesNoQuestion('If Yes, experiencing cough or breathlessness?', 'cough_or_breathlessness'),
                          SizedBox(height: dn.height(1)),
                        buildYesNoQuestion('Has the patient been changed to green tube?', 'changed_to_green_tube'),
                        SizedBox(height: dn.height(1)),
                        buildDropdown('Spigotting status'),
                        SizedBox(height: dn.height(1)),
                        buildYesNoQuestion('Is the patient able to breathe through nose while blocking the tube?', 'able_to_breathe_through_nose'),
                        SizedBox(height: dn.height(1)),
                        if (patientData['able_to_breathe_through_nose'] == "Yes")
                          buildTextField('If Yes, breath duration', (value) {
                            patientData['breath_duration'] = value;
                          }, patientData['breath_duration']),
                        SizedBox(height: dn.height(10)),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }

  Widget buildTextField(String labelText, Function(String) onChanged,String value,{bool isNumber = false} ) {
    return Row(
      children: [
        Expanded(child: Text(labelText)),
        SizedBox(
          width: 100,
          child: TextFormField(
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            initialValue: value,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(label: Text("Yes"),
              backgroundColor: patientData[key]=="Yes"?CupertinoColors.systemGreen:CupertinoColors.systemGrey4,
              
              ),
            ),

            Chip(label: Text("No"),
            backgroundColor:    patientData[key]=="No"?CupertinoColors.systemRed:CupertinoColors.systemGrey4
            )
          ],
        ),
      ],
    );
  }

  Widget buildDropdown(String label) {
    return Row(
      children: [
        Expanded(child: Text(label,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5,decoration: TextDecoration.underline),)),
        
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

}