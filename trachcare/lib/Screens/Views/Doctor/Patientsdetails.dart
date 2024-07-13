import 'package:flutter/material.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:trachcare/components/PatientsDataModel.dart';

class Patientsdetails extends StatelessWidget {
  final Patientsdatamodel patientsdata;
  const Patientsdetails({super.key, required this.patientsdata, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(Title: 'Patients details'),
      body: ListView(
        children: [
          Image.network('src'),
          const Text('desc')
        ],
      ),

    );
  }
}