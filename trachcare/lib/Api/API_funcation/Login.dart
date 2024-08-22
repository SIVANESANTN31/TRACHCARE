import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:trachcare/Api/Apiurl.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import "package:http/http.dart" as http;
import 'package:trachcare/Screens/Views/patient/patientScreenmain.dart';

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
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Doctormainpage()));
    LoginData.clear();
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
      title: Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
      showIcon: true, // show or hide the icon
      
      autoCloseDuration: const Duration(seconds: 2),
    );
      
    }
    
  }


// patient Login funcations


  void Patientlogin(BuildContext context)async{
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
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PatientMainScreen()));
    LoginData.clear();
    patient_id = data['userInfo']['patient_id'];
    
    


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
      title: Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
      showIcon: true, // show or hide the icon
      
      autoCloseDuration: const Duration(seconds: 2),
    );
      
    }
    

  }
  



}