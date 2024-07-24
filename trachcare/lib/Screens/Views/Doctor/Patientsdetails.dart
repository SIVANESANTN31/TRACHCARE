import 'package:flutter/material.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:trachcare/components/PatientsDataModel.dart';

import 'profilefeild.dart';

class Patientsdetails extends StatelessWidget {
  final int patientId;

  const Patientsdetails({Key? key, required this.patientId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(Title: 'Patients details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(child: Column(
            children: [
              Text('$patientId',),
              const SizedBox(height: 20.0),
              const ProfileField(title: 'Username', value: 'XYX'),
              const SizedBox(height: 20.0),
              const ProfileField(title: 'Username', value: 'XYX'),
              const SizedBox(height: 20.0),
              const ProfileField(title: 'Username', value: 'XYX'),
              const SizedBox(height: 20.0),
              const ProfileField(title: 'Username', value: 'XYX'),
              const SizedBox(height: 20.0),
              const ProfileField(title: 'Username', value: 'XYX'),
              const SizedBox(height: 20.0),
              const ProfileField(title: 'Username', value: 'XYX'),
              const SizedBox(height: 20.0),
              const ProfileField(title: 'Username', value: 'XYX'),
              const SizedBox(height: 20.0),
              const ProfileField(title: 'Username', value: 'XYX'),
              const SizedBox(height: 20.0),
              const ProfileField(title: 'Username', value: 'XYX'),
            ],
          ),),
        ),
      ),
      

    );
  }
}