import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trachcare/Screens/Views/Admin/Adminscreens/patientslist.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/utils/Dimention.dart';

class ViewPatientDetails extends StatefulWidget {
  final String patientId;

  const ViewPatientDetails({super.key, required this.patientId});
  @override
  _ViewPatientDetailsState createState() => _ViewPatientDetailsState();
}

class _ViewPatientDetailsState extends State<ViewPatientDetails> {
  Map<String, dynamic> patientDetails = {}; // To store fetched data
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          patientDetails = {
            'name': data['username'],
            'age': data['age'] ?? 'NIL',
            'address': data['address'] ?? 'NIL',
            'bmi': data['bmi'] ?? 'NIL',
            'diagnosis': data['diagnosis'] ?? 'NIL',
            'surgeryStatus': data['surgery_status'] ?? 'NIL',
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
            'image': data['image_path'].toString().substring(2),
          };
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
      appBar: NormalAppbar(
        Title: "Patient Details",
        height: dn.height(10),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => patients_list(),
          ));
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: patientDetails.isNotEmpty
              ? Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                          Center(
  child: ClipOval(
    child: Image.network(
      "https://$ip/Trachcare/${patientDetails['image']}",  // Ensure full URL
      height: dn.height(20),
      width: dn.height(20),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.person, size: 100); // Placeholder if image fails to load
      },
    ),
  ),
),
                      SizedBox(height: 20),
                      buildFormField('Name', patientDetails['name']),
                      buildFormField('Age', patientDetails['age']),
                      buildFormField('Address', patientDetails['address']),
                      buildFormField('BMI', patientDetails['bmi']),
                      buildFormField('Diagnosis', patientDetails['diagnosis']),
                      buildFormField('Surgery Status', patientDetails['surgeryStatus']),
                      buildFormField('Post-Op Tracheostomy Day', patientDetails['postOpTracheostomyDay']),
                      buildFormField('Tube Name and Size', patientDetails['tubeNameSize']),
                      buildFormField('Baseline Vitals', patientDetails['baselineVitals']),
                      buildFormField('Respiratory Rate', patientDetails['respiratoryRate']),
                      buildFormField('Heart Rate', patientDetails['heartRate']),
                      buildFormField('SPO2 @ Room Air', patientDetails['spo2RoomAir']),
                      buildFormField('Indication of Tracheostomy', patientDetails['indicationOfTracheostomy']),
                      buildFormField('Comorbidities', patientDetails['comorbidities']),
                      buildFormField('Hemoglobin', patientDetails['hemoglobin']),
                      buildFormField('Sr. Sodium', patientDetails['srSodium']),
                      buildFormField('Sr. Potassium', patientDetails['srPotassium']),
                      buildFormField('Sr. Calcium', patientDetails['srCalcium']),
                      buildFormField('Sr. Bicarbonate', patientDetails['srBicarbonate']),
                      buildFormField('PT', patientDetails['pt']),
                      buildFormField('APTT', patientDetails['aptt']),
                      buildFormField('INR', patientDetails['inr']),
                      buildFormField('Platelets', patientDetails['platelets']),
                      buildFormField('Liver Function Test', patientDetails['liverFunctionTest']),
                      buildFormField('Renal Function Test', patientDetails['renalFunctionTest']),
                      SizedBox(height: dn.height(10)),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()), // Show a loading spinner while fetching data
        ),
      ),
    );
  }

  // Function to build a form field for each patient detail
  Widget buildFormField(String label, String? initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        initialValue: initialValue ?? 'Not available',
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        readOnly: true, // Set to false if you want to allow editing
      ),
    );
  }
}
