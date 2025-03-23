import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/components/information.dart';
import 'package:trachcare/Screens/started/WelcomePage.dart';
import 'package:trachcare/components/custom_button.dart';
import 'package:trachcare/style/colors.dart';
import '../style/utils/Dimention.dart';

class drawer extends StatelessWidget {
  final String Name;
  final imagepath;
  final String reg_no;
  final  onTap;
  drawer({super.key, required this.Name,  required this.reg_no, required this.imagepath, required this.onTap});



  @override
  Widget build(BuildContext context) {
Dimentions dn = Dimentions(context);
Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
}
}


Future<void> _launchURLmail(Uri url) async {
  // Check if the device is iOS and adjust the URL scheme
  if (Platform.isIOS) {
    url = Uri(
      scheme: 'mailto',
      path: url.path,
      queryParameters: {'subject': 'TrachCare Support'}, // Optional subject
    );
  }

  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw Exception('Could not launch $url');
  }
}


void alertdilog(){
      showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Logout'),
        content: const Text('Are sure to Logout?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context,"no");
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
                  Navigator.of(context,rootNavigator: true).pop();
                 Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => Welcome_page()),(route)=>false);
            },
            child: const Text('Yes'),
          ),
        
      ]),
    );

    }

  void btn_fun() {
   alertdilog();
  }



    return SafeArea(
      maintainBottomViewPadding: true,
      bottom: true,
      top: false,
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
  width: dn.width(40), // Set the width for DrawerHeader
  height: dn.width(60), // Set the height for DrawerHeader
  child: DrawerHeader(
    decoration: BoxDecoration(
      color: Color(0XFFECCEA8),
    ),
    child: Center(
      child: Column(
        children: [
          SizedBox(
            width: dn.width(25), // Width of the CircleAvatar
            height: dn.width(25), // Height of the CircleAvatar
            child: CircleAvatar(
              foregroundImage: imagepath,
            ),
          ),
          Text(
            Name,
            style: GoogleFonts.ibmPlexSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          ),
          Text(
            reg_no,
            style: GoogleFonts.ibmPlexSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9.sp,
              ),
            ),
          ),
        ],
      ),
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
              onTap: onTap,
            ),
            ListTile(
               trailing:const Icon(
                Icons.chevron_right,
              ) ,
              leading: const Icon(
                Icons.info_outline,
              ),
              title: const Text('About us'),
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
                CupertinoIcons.lock_shield
              ),
              title: const Text('Privacy policy'),
              onTap: () {
                _launchInBrowser(Uri.parse('http://180.235.121.245/Trachcare/privacy_police.html'));
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
                _launchURLmail(
                  Uri(scheme: 'mailto', path: 'sivanesansoffical@gmail.com')
                );
              },
            ),
            // SizedBox(height: dn.height(20),),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: custom_Button(
                  text: "Logout",
                  button_funcation: (){
                  btn_fun();
                    },
                  width: 10,
                  height: 7,
                  backgroundColor: const Color.fromARGB(255, 62, 138, 182),
                  textcolor: whiteColor,
                  textSize: 10,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
