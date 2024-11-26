import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/components/custom_button.dart';
import 'package:trachcare/style/colors.dart';
// import 'package:trachcare/style/utils/Dimention.dart';
import '../Api/Apiurl.dart';
import '../Screens/Views/patient/Bottomnavigationscreens/PatientDashborad.dart'; // Assuming you're using Sizer for responsive design

class Spigottingsheet extends StatefulWidget {
  const Spigottingsheet({super.key});

  @override
  State<Spigottingsheet> createState() => _SpigottingsheetState();
}

class _SpigottingsheetState extends State<Spigottingsheet> {
  int? _groupValue = 2;

  TextEditingController Timingcontoller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Dimentions dn = Dimentions(context);

Future updatestatus_spogoting()async{
  var apiUrl =updatestatusspogotingurl ;
      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));

      // Add fields to the request
      request.fields.addAll({
        'patient_id': patient_id,
        'cough_or_breathlessness' : _groupValue==0?'YES':'NO',
        'breath_duration':Timingcontoller.text
      });

     

      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);
        print(data['msg']);
        if (data['Status']) {
          return true;
       
        } else {
          return false;
         
        }
      }
      return false;
    
  
  




}




void updatestatus()async{
  var apiUrl =updatestatusurl ;

  
  try {
   

      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));

      // Add fields to the request
      request.fields.addAll({
        'patient_id': patient_id,
        'issues' : _groupValue.toString(),
       
      });

     

      var response = await request.send();
      var spogotingStatus = await updatestatus_spogoting();

      // Handle the response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);
        print(data['msg']);
        print(spogotingStatus);
        if (data['Status'] && spogotingStatus) {

         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => PatientDashBoard(),
          ),(route)=>false);

          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(data['msg']),
          //   backgroundColor: Colors.green[400],
          // )
           ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Spigotting Status updated successfully'),
          backgroundColor: Colors.green[400],),
        );
        } else {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => PatientDashBoard(),
          ),(route)=>false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data['message']),
            backgroundColor: Colors.red,
          ));
        }
      } else {
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => PatientDashBoard(),
          ),(route)=>false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Server error: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ));
      }
    }
   catch (e) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => PatientDashBoard(),
          ),(route)=>false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong !!!"+e.toString() )),
    );
  }





}






void savebtn()  {
updatestatus();


}





















    return CupertinoPageScaffold(
      resizeToAvoidBottomInset:false,
      navigationBar: CupertinoNavigationBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.xmark_circle_fill,
              color: CupertinoColors.systemGrey,
              size: 22,
            ),
          ),
        ),
        middle: Text(
          "Spigotting Questions",
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ),
      child: 
         SafeArea(
           child: SingleChildScrollView(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.quiz_rounded),
                        title: Text('Spigotting Status'),
                        subtitle: Text(
                            'Is the patient able to breathe through the nose while blocking the tube with hands?'),
                      ),
                      RadioListTile<int>(
                        title: const Text('YES'),
                        value: 0,
                        groupValue: _groupValue,
                        activeColor: CupertinoColors.systemGreen,
                        onChanged: (int? value) {
                          setState(() {
                            _groupValue = value;
                          });
                        },
                      ),
                      
                      RadioListTile<int>(
                        title: const Text('NO'),
                        value: 1,
                        groupValue: _groupValue,
                        activeColor: CupertinoColors.systemRed,
                        onChanged: (int? value) {
                          setState(() {
                            _groupValue = value;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      if (_groupValue == 0)
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                leading: Icon(Icons.quiz_rounded),
                                title: Text(
                                    'If Yes, How long the patient can able to breath ?'),
                                // subtitle: Text(
                                //     'Is the patient able to breathe through the nose while blocking the tube with hands?'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CupertinoTextField(
                                  controller: Timingcontoller,
                                  keyboardType:TextInputType.number,
                                  placeholder: "Enter the Timing!",
                                ),
                              )
                            ]),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                custom_Button(
                    text: "Save",
                    width: 45,
                    height: 6,
                    backgroundColor: sucess_color,
                    textcolor: CupertinoColors.white,
                    button_funcation: savebtn,
                    textSize: 12)
              ],
                     ),
           ),
         ),
      );
    
  }
}

// class Questions_Widget extends StatefulWidget {
//   const Questions_Widget({super.key});

//   @override
//   State<Questions_Widget> createState() => _Questions_WidgetState();
// }

// class _Questions_WidgetState extends State<Questions_Widget> {
//   // Move _groupValue here to persist across rebuilds
 

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
