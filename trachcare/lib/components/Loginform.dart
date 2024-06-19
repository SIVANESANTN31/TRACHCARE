import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/components/custom_button.dart";
import "package:trachcare/style/colors.dart";

class loginForm extends StatelessWidget {
  const loginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      height: 32.h,
      decoration: BoxDecoration(
          color: loginFormcolor, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Form(
          child: Column(
            children: [
              SizedBox(
                  width: 70.w,
                  height: 6.h,
                  child: TextFormField(
                    cursorColor: TitleColor,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Username",
                      filled: true,
                      fillColor: whiteColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )),
              Gap(2.5.h),
              SizedBox(
                  width: 70.w,
                  height: 6.h,
                  child: TextFormField(
                    cursorColor: TitleColor,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: whiteColor,
                      suffixIcon: Icon(CupertinoIcons.eye_slash_fill),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 140),
                child: Text(
                  "Forget Password",
                  style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Color(0XFF455A64),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Gap(1.h),
              custom_Button(
                  text: "Signup",
                  width: 75,
                 // icon: CupertinoIcons.right_chevron,
                  height: 6,
                  backgroundColor: TitleColor,
                  textcolor: whiteColor,
                  textSize: 13)
            ],
          ),
        ),
      ),
    );
  }
}
