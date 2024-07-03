import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Api/DataStore/Datastore.dart";
import "package:trachcare/components/custom_button.dart";
import "package:trachcare/style/colors.dart";

class loginForm extends StatelessWidget {
  final Singup_button;

  final GlobalKey<FormState> formKey;
   loginForm({super.key, this.Singup_button, required this.formKey});

LoginDataStore store = LoginDataStore();
  
  String username ="";
  String password =" ";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      height: 35.h,
      decoration: BoxDecoration(
          color: loginFormcolor, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                  width: 70.w,
                  height: 8.h,
                  child: TextFormField(
                    validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Username';
              }
              return null;
            },
            onSaved: (value) {
                  username  = value!; 
                  store.Setusername(username);
                  
                },
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
                  height: 8.h,
                  child: TextFormField(
                    validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter password';
                
              }
              return null;
            },
            onSaved: (value) {
                  password  = value!;
                  store.SetPassword(password);
                },
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
              Gap(2.h),
              custom_Button(
                  text: "Signup",
                  width: 55,
                 button_funcation: Singup_button,
                  height: 6.5,
                  backgroundColor: TitleColor,
                  textcolor: whiteColor,
                  textSize: 13,
                  // boxShadow:
                  //           BoxShadow(color: Colors.black.withOpacity(0.25),
                  //           spreadRadius: 5,
                  //           blurRadius: 7,
                  //           offset: Offset(0, 3)),
                            )
            ],
          ),
        ),
      ),
    );
  }
}
