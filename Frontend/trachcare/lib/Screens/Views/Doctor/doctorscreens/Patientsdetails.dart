import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/editpatientdetails.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../components/NAppbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';
import '../Bottomnavigator/patientslist.dart';

class ViewPatientDetails extends StatefulWidget {
  final String patientId;
  final String patientName;
   // Optional, in case you want to pass the name


  const ViewPatientDetails({super.key, required this.patientId, required this.patientName,});
  @override
  _ViewPatientDetailsState createState() => _ViewPatientDetailsState();
}

class _ViewPatientDetailsState extends State<ViewPatientDetails> {

  // String patient_id = patientId;
  Map<String, dynamic> patientDetails = {}; // To store fetched data

    var imagefile, base64encode, fileimage;

  @override
  void initState() {
    super.initState();
    fetchPatientDetails(); // Fetch data when the screen loads
  }

  // Function to fetch patient details from the server
  Future<void> fetchPatientDetails() async {
    final String url = '$ViewPatientDetailsUrl?patient_id=${widget.patientId}';
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
       print(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        patientDetails = {
          'name': data['username'] ,
          'age': data['age'] ?? 'NIL',
          'address': data['address'] ?? 'NIL',
          'bmi': data['bmi'] ?? 'NIL',
          'diagnosis': data['diagnosis'] ?? 'NIL',
          'surgery_Status': data['surgery_status'] ?? 'NIL',
          'postOpTracheostomyDay': data['post_op_tracheostomy_day'] ?? 'NIL',
          'tubeNameSize': data['tube_name_size'] ?? 'NIL',
          'baselineVitals': data['baseline_vitals'] ?? 'NIL',
          'respiratoryRate': data['respiratory_rate'] ?? 'NIL',
          'heartRate': data['heart_rate'] ?? 'NIL',
          'spo2RoomAir': data['spo2_room_air'] ?? 'NIL',
          'indicationOfTracheostomy': data['indication_of_tracheostomy'] ?? 'NIL',
          'comorbidities': data['comorbidities'] ?? 'NIL',
          'hemoglobin': data['hemoglobin'] ?? 'NIL',
          'srSodium': data['sr_sodium'] ?? 'NIL',
          'srPotassium': data['sr_potassium'] ?? 'NIL',
          'srCalcium': data['sr_calcium'] ?? 'NIL',
          'srBicarbonate': data['sr_bicarbonate'] ?? 'NIL',
          'pt': data['pt'] ?? 'NIL',
          'aptt': data['aptt'] ?? 'NIL',
          'inr': data['inr'] ?? 'NIL',
          'platelets': data['platelets'] ?? 'NIL',
          'liverFunctionTest': data['liver_function_test'] ?? 'NIL',
          'renalFunctionTest': data['renal_function_test'] ?? 'NIL',
        };
      });
    } else {
      print('Failed to load patient details');
    }
  } catch (e) {
    print('Error fetching patient details: $e');
  }
}

  void _save(BuildContext context) {
    // if (_formKey.currentState!.validate()) {
    //   updatepatientDetails(
    //     context,
    //     widget.Doctor_id ,
    //      imagefile,
       
    //   );

    //   _formKey.currentState!.reset();
    //   setState(() {
    //     usernameController.clear();
    //     doctorRegNoController.clear();
    //     emailController.clear();
    //     phoneNumberController.clear();
    //     passwordController.clear();
    //     imagefile = null;
    //   });
    // }
  }

  
  void getimage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (file != null) {
      final imageBytes = await file.readAsBytes();
      var base64encoder = base64Encode(imageBytes);
      setState(() {
        base64encode = base64encoder;
      });
      setState(() {
        imagefile = File(file.path);
        fileimage = file.path;
        print(fileimage);
      });
    }
  }

  void photo_picker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              getimage(source: ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            isDefaultAction: true,
            onPressed: () {
              getimage(source: ImageSource.gallery);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: "Patient Details", height: dn.height(10), onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) => patientslist(),),);
      },),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: patientDetails.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextView('Name', patientDetails['name'] as String?),
                    buildTextView('Age', patientDetails['age'] as String?),
                    buildTextView('Address', patientDetails['address'] as String?),
                    buildTextView('BMI', patientDetails['bmi'] as String?),
                    buildTextView('Diagnosis', patientDetails['diagnosis'] as String?),
                    buildTextView('Surgery Status', patientDetails['surgery_Status'] as String?),
                    buildTextView('Post-Op Tracheostomy Day', patientDetails['postOpTracheostomyDay'] as String?),
                    buildTextView('Tube Name and Size', patientDetails['tubeNameSize'] as String?),
                    buildTextView('Baseline Vitals', patientDetails['baselineVitals'] as String?),
                    buildTextView('Respiratory Rate', patientDetails['respiratoryRate'] as String?),
                    buildTextView('Heart Rate', patientDetails['heartRate'] as String?),
                    buildTextView('SPO2 @ Room Air', patientDetails['spo2RoomAir'] as String?),
                    buildTextView('Indication of Tracheostomy', patientDetails['indicationOfTracheostomy'] as String?),
                    buildTextView('Comorbidities', patientDetails['comorbidities'] as String?),
                    buildTextView('Hemoglobin', patientDetails['hemoglobin'] as String?),
                    buildTextView('Sr. Sodium', patientDetails['srSodium'] as String?),
                    buildTextView('Sr. Potassium', patientDetails['srPotassium'] as String?),
                    buildTextView('Sr. Calcium', patientDetails['srCalcium'] as String?),
                    buildTextView('Sr. Bicarbonate', patientDetails['srBicarbonate'] as String?),
                    buildTextView('Sr. Bicarbonate', patientDetails['srBicarbonate'] as String?),
                    buildTextView('PT', patientDetails['pt'] as String?),
                    buildTextView('APTT', patientDetails['aptt'] as String?),
                    buildTextView('INR', patientDetails['inr'] as String?),
                    buildTextView('Platelets', patientDetails['platelets'] as String?),
                    buildTextView('Liver Function Test', patientDetails['liverFunctionTest'] as String?),
                    buildTextView('Renal Function Test', patientDetails['renalFunctionTest'] as String?),
                    const SizedBox(height: 24),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                custom_Button(
                                text: "Edit",
                                width: dn.width(10.5),
                                height: dn.height(1.2),
                                backgroundColor: Colors.green,
                                textcolor: whiteColor,
                                button_funcation: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Editpatientdetails(patientId: '', patientName: '',)),);
                                },
                                textSize: 10),
                                 Center(
                                   child: custom_Button(
                                                                   text: "delete",
                                                                   width: dn.width(11),
                                                                   height: dn.height(1.2),
                                                                   backgroundColor: const Color.fromARGB(255, 243, 33, 33),
                                                                   textcolor: whiteColor,
                                                                   button_funcation: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                                                 builder: (context) => patientslist(),));
                                                                   },
                                                                   textSize: 10),
                                 ),
                              ],
                        ),
                      ),
                      const SizedBox(height: 70),
                  ],
                )
              : const Center(child: CircularProgressIndicator()), // Show a loading spinner while fetching data 
        ),
      ),
    );
  }

  // Function to build a text display for each field
  Widget buildTextView(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value ?? 'Not available'), // Provide a default text if value is null
      ],
    ),
  );
}

}
