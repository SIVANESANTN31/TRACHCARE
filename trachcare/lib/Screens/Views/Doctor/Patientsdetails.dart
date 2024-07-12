import 'package:flutter/material.dart';

class Patientsdetails extends StatelessWidget {
  const Patientsdetails(patient_name, {super.key, required display_list, required patientslist, required Patientsdetails});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Patients details'),);
  }
}