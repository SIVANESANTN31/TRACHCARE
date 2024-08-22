import 'package:flutter/material.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:trachcare/components/PatientsDataModel.dart';

import '../../../../components/profilefeild.dart';
import '../../../../style/utils/Dimention.dart';

class Patientsdetails extends StatelessWidget {

  const Patientsdetails({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: 'Patients details', height: dn.height(15),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(child: Column(
            children: [
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