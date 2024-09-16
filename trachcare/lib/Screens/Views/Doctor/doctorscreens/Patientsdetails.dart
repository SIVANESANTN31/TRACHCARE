import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../components/NAppbar.dart';
import 'package:trachcare/components/NAppbar.dart';
import '../../../../components/profilefeild.dart';
import '../../../../style/utils/Dimention.dart';

class ViewPatientDetails extends StatefulWidget {
  final String patientId;
  final String patientName;
  final String doctorId;  // Optional, in case you want to pass the name


  const ViewPatientDetails({Key? key, required this.patientId, required this.patientName,required this.doctorId,}) : super(key: key);
  @override
  _ViewPatientDetailsState createState() => _ViewPatientDetailsState();
}

class _ViewPatientDetailsState extends State<ViewPatientDetails> {

  
  Map<String, dynamic> patientDetails = {}; // To store fetched data

  @override
  void initState() {
    super.initState();
    fetchPatientDetails(); // Fetch data when the screen loads
  }

  // Function to fetch patient details from the server
  Future<void> fetchPatientDetails() async {
    try {
      // Replace with your API URL
      final response = await http.get(Uri.parse(ViewPatientDetailsUrl));

      if (response.statusCode == 200) {
        setState(() {
          patientDetails = json.decode(response.body);
        });
      } else {
        print('Failed to load patient details');
      }
    } catch (e) {
      print('Error fetching patient details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: "Patient Details", height: dn.height(10)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: patientDetails.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextView('Name', patientDetails['name']),
                    buildTextView('Age', patientDetails['age']),
                    buildTextView('Address', patientDetails['address']),
                    buildTextView('BMI', patientDetails['bmi']),
                    buildTextView('Diagnosis', patientDetails['diagnosis']),
                    buildTextView('Surgery Status', patientDetails['surgeryStatus']),
                    buildTextView('Post-Op Tracheostomy Day', patientDetails['postOpTracheostomyDay']),
                    buildTextView('Tube Name and Size', patientDetails['tubeNameSize']),
                    buildTextView('Baseline Vitals', patientDetails['baselineVitals']),
                    buildTextView('Respiratory Rate', patientDetails['respiratoryRate']),
                    buildTextView('Heart Rate', patientDetails['heartRate']),
                    buildTextView('SPO2 @ Room Air', patientDetails['spo2RoomAir']),
                    buildTextView('Indication of Tracheostomy', patientDetails['indicationOfTracheostomy']),
                    buildTextView('Comorbidities', patientDetails['comorbidities']),
                    buildTextView('Hemoglobin', patientDetails['hemoglobin']),
                    buildTextView('Sr. Sodium', patientDetails['srSodium']),
                    buildTextView('Sr. Potassium', patientDetails['srPotassium']),
                    buildTextView('Sr. Calcium', patientDetails['srCalcium']),
                    buildTextView('Sr. Bicarbonate', patientDetails['srBicarbonate']),
                    buildTextView('PT', patientDetails['pt']),
                    buildTextView('APTT', patientDetails['aptt']),
                    buildTextView('INR', patientDetails['inr']),
                    buildTextView('Platelets', patientDetails['platelets']),
                    buildTextView('Liver Function Test', patientDetails['liverFunctionTest']),
                    buildTextView('Renal Function Test', patientDetails['renalFunctionTest']),
                  ],
                )
              : Center(child: CircularProgressIndicator()), // Show a loading spinner while fetching data
        ),
      ),
    );
  }

  // Function to build a text display for each field
  Widget buildTextView(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
