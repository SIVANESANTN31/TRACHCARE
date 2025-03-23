// ignore_for_file: unused_import, unused_local_variable

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Screens/AuthScreens/Doctorlogin.dart";
import "package:trachcare/Screens/AuthScreens/PatientLogin.dart";
import "package:trachcare/Screens/AuthScreens/Adminlogin.dart";
import "package:trachcare/components/Titlebox.dart";
import "package:trachcare/components/custom_button.dart";
import "package:trachcare/style/colors.dart";
import "package:trachcare/style/utils/Dimention.dart";



class Welcome_page extends StatefulWidget {
  const Welcome_page({super.key});

  @override
  State<Welcome_page> createState() => _Welcome_pageState();
}

class _Welcome_pageState extends State<Welcome_page> {

   @override
  void initState() {
    super.initState();
    // Reapply immersive mode when the next screen loads
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  @override
  Widget build(BuildContext context) {
     // Ensure immersive mode for this widget
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
Dimentions dn = Dimentions(context);
var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(

              //colorFilter: ColorFilter.mode(const Color.fromARGB(255, 129, 128, 128), BlendMode.dstATop),
              opacity: 0.95,
              image: AssetImage("assets/images/welcome.png"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          top: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Titlehead(
                titleName: 'TRACHCARE',
              ),
              
              Gap(5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorLogin()));

                    },
                    child: Container(
                      width: dn.width(40),
                      height: dn.height(20),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0XFFA7DBAF), Color(0XFFD2EFD7)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [SizedBox(
  width: dn.width(20),
  height: dn.height(10),
  child: Container(
    child: ClipOval(
      child: Image.asset(
        "assets/images/doctor.png",
        fit: BoxFit.cover,
      ),
    ),
  ),
),

                          Text("Doctor",
                              style: GoogleFonts.ibmPlexSans(
                                  textStyle: const TextStyle(
                                      fontSize: 17,
                                      color: Color(0XFF455A64),
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const patientScreenlogin()),
  );
                    },
                    child: Container(
                      width: dn.width(40),
                      height: dn.height(20),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0XFFFFD9A0), Color(0XFFFFEDD2)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [SizedBox(
  width: dn.width(20),
  height: dn.height(10),
  child: ClipOval(
    child: Image.asset(
      "assets/images/patient.png",
      fit: BoxFit.cover,
    ),
  ),
),

                          Text("Patient",
                              style: GoogleFonts.ibmPlexSans(
                                  textStyle: const TextStyle(
                                      fontSize: 17,
                                      color: Color(0XFF455A64),
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                GestureDetector(
                  onTap: (){
                     Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>   AdminLogin()),
                );
                    },
                    child: Container(
                      width: dn.width(60),
                      height: dn.height(7),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 35, 198, 60), Color.fromARGB(255, 153, 255, 168)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("ADMIN",
                              style: GoogleFonts.ibmPlexSans(
                                  textStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Color(0XFF455A64),
                                  fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
                  

                  
            ],
          ),
        ),
      ),
    );
  }
}
