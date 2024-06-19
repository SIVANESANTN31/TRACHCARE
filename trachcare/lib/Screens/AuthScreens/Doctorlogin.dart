import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/components/Loginform.dart";
import "package:trachcare/components/Titlebox.dart";
import "package:trachcare/components/subhead.dart";
import "package:trachcare/style/colors.dart";

class doctorScreenlogin extends StatefulWidget {
  const doctorScreenlogin({super.key});

  @override
  State<doctorScreenlogin> createState() => _doctorScreenloginState();
}

class _doctorScreenloginState extends State<doctorScreenlogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: Icon(CupertinoIcons.chevron_back),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Titlehead(titleName: "TRACHCARE"),
            subhead(Subhead: "Login"),
            Gap(2.h),
            Container(
              width: double.infinity,
              height: 32.h ,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/2.png"))),
            ),
            Gap(2.5.h),
            loginForm(),
            
          ],),
        ),
      ),
    );
  }
}