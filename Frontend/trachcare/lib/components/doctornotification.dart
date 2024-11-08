
// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/style/utils/Dimention.dart';


class doctornotificationssheet extends StatelessWidget {
  List issuesList;
   doctornotificationssheet({super.key, required this.issuesList});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
              )),
        ),
        middle: Text("Notification Center",
            style: TextStyle(
                fontSize: 12.sp,
          
              )),
      ),
      child: Scaffold(
        body: 
          
          ListView.builder(
            itemCount: issuesList.length,
            itemBuilder: (BuildContext context,int index){
              var patientid = issuesList[index]['username'];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IOSNotificationstyle(context,patientid),
            );
          
  })
      ));
  }
}



///  notification starting from here
/// 
/// 


Widget IOSNotificationstyle(BuildContext context,var patient_id) {
  Dimentions dn = Dimentions(context);
  return Dismissible(
    key: UniqueKey(), // A unique key is required for dismissible
    direction: DismissDirection.horizontal, // Dismiss from right to left
    onDismissed: (direction) {
      // Add your logic here when the item is dismissed
      // For example, removing it from a list
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Notification dismissed'),
      ));
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: dn.width(95),
      height: dn.height(11.5),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // Shadow color with opacity
            spreadRadius: 2, // How wide the shadow spreads
            blurRadius: 6, // How much the shadow is blurred
            offset: Offset(4, 4), // Shadow position (horizontal, vertical) is suffering from the breathing illness
          ),
        ],
      ),
      child: ListTile(
        title: Text("${patient_id}"),
        subtitle: Text("is suffering from the breathing illness"),
        leading: Icon(CupertinoIcons.bell_fill, color: CupertinoColors.systemYellow),
        
      ),
    ),
  );
  }
