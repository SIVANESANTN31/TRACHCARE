// ignore_for_file: unused_import

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Api/API_funcation/Login.dart";
import "package:trachcare/Screens/Views/patient/Bottomnavigationscreens/PatientDashborad.dart";
import "package:trachcare/Screens/Views/patient/patientScreenmain.dart";
import "package:trachcare/components/Loginform.dart";
import "package:trachcare/components/Titlebox.dart";
import "package:trachcare/components/subhead.dart";
import "package:trachcare/style/colors.dart";

class patientScreenlogin extends StatefulWidget {
  const patientScreenlogin({super.key});

  @override
  State<patientScreenlogin> createState() => _patientScreenloginState();
}

class _patientScreenloginState extends State<patientScreenlogin> {

  final _formkey = GlobalKey<FormState>();

  void Loign_btn(){

        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();  
          LoginClassApi().Patientlogin(context);
          _formkey.currentState!.reset();

        

        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.chevron_back)),
        
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Titlehead(titleName: "TRACHCARE"),
            const subhead(Subhead: "Login"),
            Gap(2.h),
            Container(
              width: double.infinity,
              height: 32.h ,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/3.png"))),
            ),
            Gap(2.5.h),
            loginForm(formKey: _formkey,Singup_button: Loign_btn,)
            
          ],),
        ),
      ),
    );
  }
}