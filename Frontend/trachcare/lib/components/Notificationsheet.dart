import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
// import 'package:trachcare/components/Appbar.dart';
// import 'package:trachcare/style/colors.dart';
import 'package:trachcare/style/utils/Dimention.dart';


class Notificationsheetwidget extends StatelessWidget {
  final String time;
   Notificationsheetwidget({super.key, required this.time});

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            IOSNotificationstyle(context,time),
            SizedBox(height: 30,),
          ],
        )
      ));
  }
}



///  notification starting from here
/// 
/// 


Widget IOSNotificationstyle(BuildContext context,String Time) {
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
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: dn.width(95),
          height: dn.height(12),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15), // Shadow color with opacity
                spreadRadius: 2, // How wide the shadow spreads
                blurRadius: 6, // How much the shadow is blurred
                offset: Offset(4, 4), // Shadow position (horizontal, vertical)
              ),
            ],
          ),
          child: Card(
            child: ListTile(
              title: Text("Spigotting Status"),
              subtitle: Text("You Missed ${Time} Routine"),
              leading: Icon(CupertinoIcons.bell_fill, color: CupertinoColors.systemYellow),
              
            ),
          ),
          
        ),
        SizedBox(height: dn.height(5),)
      ],
    ),
    
  );
}
