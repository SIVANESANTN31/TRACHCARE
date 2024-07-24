import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";

import "../../../components/custom_button.dart";
import "../../../style/colors.dart";
import "../../../components/profilefeild.dart";
// import 'package:onboarding/utils/profilefield.dart';

import "../../../components/profilefeild.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 25.h,
                  child: SafeArea(
                    child: InkWell(
                          onTap:(){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(CupertinoIcons.chevron_left,color: BlackColor,size: 28.0,),
                        ),),
                  ),
                  decoration: const BoxDecoration(
                    color: TitleColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 110,
                    left: 30,
                    right: 30,
                    bottom: 0,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: loginFormcolor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Profile',
                                  style: GoogleFonts.ibmPlexSans(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp))),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Center(
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                AssetImage('assets/images/doctor.png'),
                              ),
                            ),
                          ),
                          SizedBox(height: 6,),
                          Center(
                            child: Container(
                              width: 40.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: whiteColor,
                               
                                
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                Text('Change Picture ',
                                  style: GoogleFonts.ibmPlexSans(
                                      textStyle: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 11.sp))),
                                  Icon(Icons.image),
                        ]),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const ProfileField(title: 'Username', value: 'XYX'),
                          const SizedBox(height: 20.0),
                          const ProfileField(
                              title: 'Email Id', value: 'XYX@gmail.com'),
                          const SizedBox(height: 20.0),
                          const ProfileField(
                              title: 'Phone Number', value: '123456789'),
                          const SizedBox(height: 20.0),
                          const ProfileField(title: 'Password', value: '123'),
                          const SizedBox(height: 20),
                          const ProfileField(title: 'Email Id', value: 'XYX@gmail.com'),
                          const SizedBox(height: 20.0),
                          const ProfileField(title: 'Phone Number', value: '123456789'),
                          const SizedBox(height: 20.0),
                          const ProfileField(title: 'Password', value: '123'),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: 4.h),
            custom_Button(
                text: "Edit Profile",
                width: 60,
                height: 6,
                button_funcation: (){},
                backgroundColor: sucess_color,
                textcolor: whiteColor,
                textSize: 13)
          ],
        ),
      ),
    );
  }
}