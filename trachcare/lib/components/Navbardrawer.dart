import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/Doctor/Profileviewpage.dart';
import 'package:trachcare/Screens/Views/Doctor/information.dart';
import 'package:trachcare/components/custom_button.dart';
import 'package:trachcare/style/Tropography.dart';
import 'package:trachcare/style/colors.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
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
                    "Sivanesan",
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
            leading: Icon(
              Icons.person,
            ),
            trailing:Icon(
              Icons.chevron_right,
            ) ,
            title: const Text('My Profile'),
            onTap: () {
               Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProfilePage(),)
                              );
            },
          ),
          ListTile(
             trailing:Icon(
              Icons.chevron_right,
            ) ,
            leading: Icon(
              Icons.info_outline,
            ),
            title: const Text('Information'),
             onTap: () {
               Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Information(),)
                              );
            },
          ),
          ListTile(
             trailing:Icon(
              Icons.chevron_right,
            ) ,
            leading: Icon(
              Icons.contacts,
            ),
            title: const Text('contacts'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Gap(40.h),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: custom_Button(
                text: "Logout",
                button_funcation: (){},
                width: 10,
                height: 6,
                backgroundColor: Logoutbtncolor,
                textcolor: whiteColor,
                textSize: 13,
                ),
          )
        ],
      ),
    );
  }
}
