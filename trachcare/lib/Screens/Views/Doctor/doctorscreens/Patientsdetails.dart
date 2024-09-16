import 'package:flutter/material.dart';
import 'package:trachcare/components/NAppbar.dart';

import '../../../../components/profilefeild.dart';
import '../../../../style/utils/Dimention.dart';

class Patientsdetails extends StatelessWidget {

  const Patientsdetails({super.key});


  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: 'Patients details', height: dn.height(15),),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(child: Column(
            children: [
              SizedBox(height: 20.0),
              ProfileField(title: 'Username', value: 'XYX'),
              SizedBox(height: 20.0),
              ProfileField(title: 'Username', value: 'XYX'),
              SizedBox(height: 20.0),
              ProfileField(title: 'Username', value: 'XYX'),
              SizedBox(height: 20.0),
              ProfileField(title: 'Username', value: 'XYX'),
              SizedBox(height: 20.0),
              ProfileField(title: 'Username', value: 'XYX'),
              SizedBox(height: 20.0),
              ProfileField(title: 'Username', value: 'XYX'),
              SizedBox(height: 20.0),
              ProfileField(title: 'Username', value: 'XYX'),
              SizedBox(height: 20.0),
              ProfileField(title: 'Username', value: 'XYX'),
              SizedBox(height: 20.0),
              ProfileField(title: 'Username', value: 'XYX'),
            ],
          ),),
        ),
      ),
      

    );
  }
}