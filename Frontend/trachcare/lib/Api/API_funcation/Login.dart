import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:trachcare/Api/Apiurl.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import "package:http/http.dart" as http;
import 'package:trachcare/Screens/Views/patient/patientScreenmain.dart';

import '../../Screens/Views/Admin/Adminmainpage.dart';
import '../../Screens/Views/Doctor/Doctormainscreen.dart';

class LoginClassApi{

  void DoctorLogin(BuildContext context)async{
    try {
      final response  =  await http.post(Uri.parse(DoctorLoginUrl),body: jsonEncode(LoginData));
      if(response.statusCode ==200){
        var data = jsonDecode(response.body);
        if(data["Status"]){
          print(data);
              toastification.show(
                type: ToastificationType.success ,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: Text('${data['message']} 🎉'),
      showProgressBar: false,
      icon: const Icon(Icons.check_circle_outline,color: Colors.green,),
      showIcon: true, // show or hide the icon
      
      autoCloseDuration: const Duration(seconds: 2),
    );
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Doctormainpage()),(route)=>false);
    LoginData.clear();
    
    Doctor_id = data['userInfo']['doctor_id'];
    
    


        }
        else{
          toastification.show(
                type: ToastificationType.error ,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: Text('${data['message']}'),
      icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
      showIcon: true, // show or hide the icon
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
    );

        }
      }
      

    } catch (e) {
      toastification.show(
                type: ToastificationType.error ,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: const Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
      showIcon: true, // show or hide the icon
      
      autoCloseDuration: const Duration(seconds: 2),
    );
      
    }
    
  }

  

// patient Login funcations

  void Patientlogin(BuildContext context)async{
    
  void alertdilog(){
      showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Daily Report'),
        content: const Text('Kindly update your Daily Queries first!!!.'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context,"Ok");
            },
            child: const Text('OK'),
          ),
          
        
      ]),
    );}

    try {
      final response  =  await http.post(Uri.parse(PatientLoginurl),body: jsonEncode(LoginData));
      if(response.statusCode ==200){
        var data = jsonDecode(response.body);
        if(data["Status"]){
          print(data);
              toastification.show(
                type: ToastificationType.success ,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: Text('${data['message']} 🎉'),
      showProgressBar: false,
      icon: const Icon(Icons.check_circle_outline,color: Colors.green,),
      showIcon: true, // show or hide the icon
      
      autoCloseDuration: const Duration(seconds: 2),
    );
     WidgetsBinding.instance.addPostFrameCallback((_) {
    alertdilog();
  });
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const PatientMainScreen()),(route)=>false);
    LoginData.clear();
    patient_id = data['userInfo']['patient_id'];
    Doctor_id = data['userInfo']['doctorid'];
    
    


        }
        else{
          toastification.show(
                type: ToastificationType.error ,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: Text('${data['message']}'),
      icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
      showIcon: true, // show or hide the icon
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
    );

        }
      }
      

    } catch (e) {
      toastification.show(
                type: ToastificationType.error ,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: const Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
      showIcon: true, // show or hide the icon
      
      autoCloseDuration: const Duration(seconds: 2),
    );
      
    }
    

  }

  void Adminlogin(BuildContext context)async{
    try {
      final response  =  await http.post(Uri.parse(AdminLoginurl),body: jsonEncode(LoginData));
      if(response.statusCode ==200){
        var data = jsonDecode(response.body);
        if(data["Status"]){
          print(data);
              toastification.show(
                type: ToastificationType.success ,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: Text('${data['message']} 🎉'),
      showProgressBar: false,
      icon: const Icon(Icons.check_circle_outline,color: Colors.green,),
      showIcon: true, // show or hide the icon
      
      autoCloseDuration: const Duration(seconds: 2),
    );
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Adminmainpage()),(route)=>false);
    LoginData.clear();
    Doctor_id = data['userInfo']['doctor_id'];
    
    


        }
        else{
          toastification.show(
                type: ToastificationType.error ,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: Text('${data['message']}'),
      icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
      showIcon: true, // show or hide the icon
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
    );

        }
      }
      

    } catch (e) {
      toastification.show(
                type: ToastificationType.error ,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: const Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
      showIcon: true, // show or hide the icon
      
      autoCloseDuration: const Duration(seconds: 2),
    );
      
    }
    

  }

  void adminlogin(BuildContext context) {}
  
  



}