import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Api/DataStore/Datastore.dart";
import "package:trachcare/components/custom_button.dart";
import "package:trachcare/style/colors.dart";

import "../style/utils/Dimention.dart";

class loginForm extends StatefulWidget {
  final Singup_button;

  final GlobalKey<FormState> formKey;
   loginForm({super.key, this.Singup_button, required this.formKey});

  @override
  State<loginForm> createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
LoginDataStore store = LoginDataStore();

  String username ="";

  String password =" ";

    bool visiblilty = true;
  @override
  Widget build(BuildContext context) {
Dimentions dn = new Dimentions(context);

    return Container(
      width: dn.width(90),
      height: dn.height(35),
      decoration: BoxDecoration(
          color: loginFormcolor, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              SizedBox(
                  width: 70.w,
                  height: 8.h,
                  child: TextFormField(
                    validator: (value) {
                      String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                final regex = RegExp(pattern);
              if (value == null || value.isEmpty||regex.hasMatch(value)==false) {
                return 'Please Enter vaild Email ID';
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
                    obscureText: visiblilty,
                    decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: whiteColor,
                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          visiblilty = !visiblilty;
                                        });
                                      },
                                      icon: visiblilty
                                          ? Icon(
                                              CupertinoIcons.eye_slash,
                                              size: 28.0,
                                            )
                                          : Icon(
                                              CupertinoIcons.eye,
                                              size: 28.0,
                                            )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onEditingComplete: widget.Singup_button,
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
                  text: "SignIn",
                  width: 55,
                 button_funcation: widget.Singup_button,
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
