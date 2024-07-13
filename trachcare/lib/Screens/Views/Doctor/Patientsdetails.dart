import 'package:flutter/material.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:trachcare/components/PatientsDataModel.dart';

class Patientsdetails extends StatelessWidget {
  final int patientId;

  const Patientsdetails({Key? key, required this.patientId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(Title: 'Patients details'),
      body: Center(child: Text('$patientId',)),

    );
  }
}