import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Screens/AuthScreens/Doctorlogin.dart";
import "package:trachcare/Screens/AuthScreens/PatientLogin copy.dart";
import "package:trachcare/components/Titlebox.dart";
import "package:trachcare/components/custom_button.dart";
import "package:trachcare/style/colors.dart";

class Welcome_page extends StatefulWidget {
  const Welcome_page({super.key});

  @override
  State<Welcome_page> createState() => _Welcome_pageState();
}

class _Welcome_pageState extends State<Welcome_page> {
  @override
  Widget build(BuildContext context) {


void Admin(){

}



    var Screen_Size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
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
              Titlehead(
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
                      width: 130,
                      height: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0XFFA7DBAF), Color(0XFFD2EFD7)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/doctor.png"),
                            ),
                          ),
                          Text("Doctor",
                              style: GoogleFonts.ibmPlexSans(
                                  textStyle: TextStyle(
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
                      width: 130,
                      height: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0XFFFFD9A0), Color(0XFFFFEDD2)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/patient.png"),
                            ),
                          ),
                          Text("Patient",
                              style: GoogleFonts.ibmPlexSans(
                                  textStyle: TextStyle(
                                      fontSize: 17,
                                      color: Color(0XFF455A64),
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              custom_Button(
                  text: "ADMIN",
                  button_funcation: Admin,
                  width: 60,
                  height: 6.5,
                  backgroundColor: TitleColor ,
                  textcolor: whiteColor,
                  textSize: 15),

                  
            ],
          ),
        ),
      ),
    );
  }
}
