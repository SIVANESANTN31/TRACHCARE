
import 'package:flutter/material.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';

import '../../../../Api/API_funcation/patientsdetails.dart';
import '../../../../components/Appbar_copy.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/utils/Dimention.dart';

class Addpatients extends StatefulWidget {
  const Addpatients({super.key});

  @override
  _AddpatientsState createState() => _AddpatientsState();
}

class _AddpatientsState extends State<Addpatients> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String age = '';
  String address = '';
  String bmi = '';
  String diagnosis = '';
  String surgeryStatus = '';
  String postOpTracheostomyDay = '';
  String tubeNameSize = '';
  String baselineVitals = '';
  String respiratoryRate = '';
  String heartRate = '';
  String spo2RoomAir = '';
  String indicationOfTracheostomy = '';
  String comorbidities = '';
  String hemoglobin = '';
  String srSodium = '';
  String srPotassium = '';
  String srCalcium = '';
  String srBicarbonate = '';
  String pt = '';
  String aptt = '';
  String inr = '';
  String platelets = '';
  String liverFunctionTest = '';
  String renalFunctionTest = '';

  void _save(BuildContext context) {
  if (_formKey.currentState!.validate()) {
    // Handle form submission
    final patientDetails = {
                        'doctorid': Doctor_id,
                        'name': name,
                        'age': age,
                        'address': address,
                        'bmi': bmi,
                        'diagnosis': diagnosis,
                        'surgeryStatus': surgeryStatus,
                        'postOpTracheostomyDay': postOpTracheostomyDay,
                        'tubeNameSize': tubeNameSize,
                        'baselineVitals': baselineVitals,
                        'respiratoryRate': respiratoryRate,
                        'heartRate': heartRate,
                        'spo2RoomAir': spo2RoomAir,
                        'indicationOfTracheostomy': indicationOfTracheostomy,
                        'comorbidities': comorbidities,
                        'hemoglobin': hemoglobin,
                        'srSodium': srSodium,
                        'srPotassium': srPotassium,
                        'srCalcium': srCalcium,
                        'srBicarbonate': srBicarbonate,
                        'pt': pt,
                        'aptt': aptt,
                        'inr': inr,
                        'platelets': platelets,
                        'liverFunctionTest': liverFunctionTest,
                        'renalFunctionTest': renalFunctionTest,};
                        SubmitPatientDetails(context, patientDetails);

    // Clear the form fields after submission
    // nameController.clear();
    // ageController.clear();
    // addressController.clear();
    // bmiController.clear();
    // diagnosisController.clear();
    // surgeryStatusController.clear();
    // postOpTracheostomyDayController.clear();
    // tubeNameSizeController.clear();
    // baselineVitalsController.clear();
    // respiratoryRateController.clear();
    // heartRateController.clear();
    // spo2RoomAirController.clear();
    // indicationOfTracheostomyController.clear();
    // comorbiditiesController.clear();
    // hemoglobinController.clear();
    // srSodiumController.clear();
    // srPotassiumController.clear();
    // srCalciumController.clear();
    // srBicarbonateController.clear();
    // ptController.clear();
    // apttController.clear();
    // inrController.clear();
    // plateletsController.clear();
    // liverFunctionTestController.clear();
    // renalFunctionTestController.clear();

    // Optionally, reset the form state
    _formKey.currentState!.reset();
  }
}

  

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: Duplicate_Appbar(Title: "Patient Details", height: dn.height(10)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   'Enter Patient Details',
                //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: 20.0),
                buildTextField('Name', (value) => name = value),
                buildTextField('Age', (value) => age = value),
                buildTextField('Address', (value) => address = value),
                buildTextField('BMI', (value) => bmi = value),
                buildTextField('Diagnosis', (value) => diagnosis = value),
                buildTextField('Surgery Status', (value) => surgeryStatus = value),
                buildTextField('Post-Op Tracheostomy Day',(value) => postOpTracheostomyDay = value),
                buildTextField('Tube Name and Size', (value) => tubeNameSize = value),
                buildTextField('Baseline Vitals', (value) => baselineVitals = value),
                buildTextField('Respiratory Rate', (value) => respiratoryRate = value),
                buildTextField('Heart Rate', (value) => heartRate = value),
                buildTextField('SPO2 @ Room Air', (value) => spo2RoomAir = value),
                buildTextField('Indication of Tracheostomy',(value) => indicationOfTracheostomy = value),
                buildTextField('Comorbidities', (value) => comorbidities = value),
                buildTextField('Hemoglobin', (value) => hemoglobin = value),
                buildTextField('Sr. Sodium', (value) => srSodium = value),
                buildTextField('Sr. Potassium', (value) => srPotassium = value),
                buildTextField('Sr. Calcium', (value) => srCalcium = value),
                buildTextField('Sr. Bicarbonate', (value) => srBicarbonate = value),
                buildTextField('PT', (value) => pt = value),
                buildTextField('APTT', (value) => aptt = value),
                buildTextField('INR', (value) => inr = value),
                buildTextField('Platelets', (value) => platelets = value),
                buildTextField('Liver Function Test',(value) => liverFunctionTest = value),
                buildTextField('Renal Function Test',
                (value) => renalFunctionTest = value),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _save(context),
                      child: const Text('Save'),
                    ),const SizedBox(height: 15,),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.red,
                    //   ),
                    //   onPressed: () {
                    //     // Handle delete logic here
                    //     print('Details Deleted');
                    //   },
                    //   child: Text('Delete'),
                    // ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField(String labelText, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          onChanged(value);
        });
      },

    );
  }
}
