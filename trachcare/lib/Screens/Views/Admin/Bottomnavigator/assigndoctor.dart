import 'package:flutter/material.dart';
import '../../../../components/Appbar_copy.dart';
import '../../../../style/utils/Dimention.dart';  


class assigndoctor extends StatelessWidget {
  const assigndoctor({super.key});

  @override
  Widget build(BuildContext context) {
     Dimentions dn = Dimentions(context);
    return Scaffold(
      
      appBar: Duplicate_Appbar(Title:"Video List", height: dn.height(10)),
    );
  }
}