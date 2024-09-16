import 'package:flutter/material.dart';
import 'package:trachcare/components/NAppbar.dart';
import '../../../../style/utils/Dimention.dart';  


class assigndoctor extends StatelessWidget {
  const assigndoctor({super.key});

  @override
  Widget build(BuildContext context) {
     Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: "Assign Doctors to Patients", height: dn.height(10),),
    );
  }
}