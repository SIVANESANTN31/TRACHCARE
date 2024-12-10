// ignore_for_file: unused_import, must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/components/Navbardrawer.dart';
import 'package:trachcare/components/Notificationsheet.dart';
import 'package:trachcare/components/doctornotification.dart';
import 'package:trachcare/style/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String Name;
  final double height;
  final PreferredSizeWidget? bottom;
  final bool notification;
  final List? notificationlists;
   bool ?doctor=false;
   bool?export=false;
  final VoidCallback? onExportPressed; 
  

  Appbar({super.key, required this.Name, this.bottom, required this.height, required this.notification,  this.notificationlists, this.doctor=false,this.export=false, this.onExportPressed});




void popsheet(BuildContext context,String Time){
  
       showCupertinoModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      expand: false,
      backgroundColor: Colors.transparent, context: context,
      //duration: Duration(milliseconds: 500),
      builder: (context) => Container(
        width: 100.w,
        height: 100.h,
        child: Notificationsheetwidget(time: Time,),
        
       )
      );
    // );
  }
  void doctorpopsheet(BuildContext context,List issuesList){
  
       showCupertinoModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      expand: false,
      backgroundColor: Colors.transparent, context: context,
      //duration: Duration(milliseconds: 500),
      builder: (context) => Container(
        width: 100.w,
        height: 100.h,
        child: doctornotificationssheet(issuesList: issuesList,),
        
       )
      );
    // );
  }









  


  @override
  AppBar build(BuildContext context) {
    
    return AppBar(
      backgroundColor: TitleColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(10),
      )),
      leading: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      centerTitle: true,
      title: Padding(
        padding:const EdgeInsets.only(top: 25),
        child: Text(
          "Hi,$Name",
          style: GoogleFonts.ibmPlexSans(
              textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Stack(
            children:[ IconButton(
                onPressed: () {
                if (export == true && onExportPressed != null) {
                  onExportPressed!();  // Trigger the export function
                } else if (notification) {
                  if (doctor == false) {
                    popsheet(context, notificationlists![0]);
                  } else {
                    doctorpopsheet(context, notificationlists!);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("No notification available"),
                  ));
                }
              },
                icon: export!? Icon(
                  Icons.cloud_download_outlined,
                  color: Colors.green,
                  size: 28,
                ): Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.green,
                  size: 28,
                )),
          
               notification? Positioned(
              right: 7,
              top: 7,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '${notificationlists!.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              )) :  Positioned(
              right: 7,
              top: 7,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ))
                
                
                
                
                
                
                ]
          ),
        )
      ],
      bottom: bottom,
      automaticallyImplyLeading: false,
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(height);
}
