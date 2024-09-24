// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/Profileviewpage.dart';
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/information.dart';
import 'package:trachcare/Screens/started/WelcomePage.dart';
import 'package:trachcare/components/custom_button.dart';
import 'package:trachcare/style/Tropography.dart';
import 'package:trachcare/style/colors.dart';

class drawer extends StatelessWidget {
  final String Name;
   const drawer({super.key, required this.Name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      bottom: true,
      top: false,
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0XFFECCEA8),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        width: 35.w,
                        height: 8.h,
                        child: CircleAvatar(
                          child: Image.asset("assets/images/patient.png"),
                        )),
                    Text(
                      Name,
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp)),
                    ),
                    Text(
                      "1921000007",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10.sp)),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
              ),
              trailing:const Icon(
                Icons.chevron_right,
              ) ,
              title: const Text('My Profile'),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>  ProfilePage())
                                );
              },
            ),
            ListTile(
               trailing:const Icon(
                Icons.chevron_right,
              ) ,
              leading: const Icon(
                Icons.info_outline,
              ),
              title: const Text('Information'),
               onTap: () {
                 Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const Information(),)
                                );
              },
            ),
            ListTile(
               trailing:const Icon(
                Icons.chevron_right,
              ) ,
              leading: const Icon(
                Icons.contacts,
              ),
              title: const Text('contacts'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Gap(30.h),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: custom_Button(
                  text: "Logout",
                  button_funcation: (){
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  Welcome_page()));
                  },
                  width: 10,
                  height: 7,
                  backgroundColor: Logoutbtncolor,
                  textcolor: whiteColor,
                  textSize: 12,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
