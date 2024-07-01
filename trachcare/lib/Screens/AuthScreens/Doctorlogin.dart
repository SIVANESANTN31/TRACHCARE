import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/API_funcation/Login.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/components/Titlebox.dart';
import 'package:trachcare/components/subhead.dart';
import "package:trachcare/components/custom_button.dart";
import 'package:trachcare/Screens/Views/Doctor/Doctordb.dart';
import "package:flutter/cupertino.dart";

import '../../components/Loginform.dart';


class DoctorLogin extends StatelessWidget {
   DoctorLogin({super.key});
   
    final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    // The below funcation is Login Button fucation 
    void Login_btn(){
  if (_formkey.currentState!.validate()) {
    _formkey.currentState!.save();  
    LoginClassApi().DoctorLogin(); 
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Doctordashboard()));
  }
 
 
 }




    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: Icon(CupertinoIcons.chevron_back),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Titlehead(titleName: "TRACHCARE"),
            subhead(Subhead: "Doctor"),
            Gap(2.h),
            Container(
              width: double.infinity,
              height: 32.h ,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/2.png"))),
            ),
            Gap(2.5.h),
            loginForm(formKey: _formkey,Singup_button: Login_btn),
          ],),
        ),
      ),
    );
  }
}