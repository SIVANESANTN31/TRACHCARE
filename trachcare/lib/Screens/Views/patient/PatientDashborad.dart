import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/components/Appbar.dart";
import "package:trachcare/components/Navbardrawer.dart";
import "package:trachcare/style/colors.dart";

import "../../../style/Tropography.dart";

class PatientDashBoard extends StatelessWidget {
  const PatientDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(Name: "sivanesan",bottom: Bottom(),),
      body: Stack(
        children: [
          // Your main content goes here
          Column(
           // crossAxisAlignment: CrossAxisAlignment.ce,
            children: [
              Gap(3.h),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: 95.w,
                  height: 10.h,
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(15)),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Text("Next Appointment Date to conseil is",style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 10.sp)),),
                      
                    Container(
                      width: 20.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        border: Border.all(),borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text(" Aug 15")),
                    )
                  ],),
                ),
              ),
              
              Gap(5.h),

              Text("Exercisers For Trach Care :",textAlign: TextAlign.left,style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                        
                            fontSize: 15.sp,fontWeight: FontWeight.bold,color: Color(0XFF455A64)),))
              
            ],
          ),
          
          
        ],
      ),
    );
  }




PreferredSizeWidget Bottom(){
  return PreferredSize(
       preferredSize: Size.fromHeight(40.0),
       child: Positioned(
              top: 0.0, // Position from the top of the screen
              left: 25.0, // Position from the left of the screen
              right: 25.0, // Position from the right of the screen
              child: Container(
                height: 14.h,
                width: 97.w,
              
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
            color: BlackColor_light,
            blurRadius: 4.0,
          ),
                  ]
                ),
                child: Column(
                  children: [
                    Text("Spigotting Status : How long the patient can able to breath ?",style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 13.sp))
                ,)
                  ],
                )
              ),
            ),
     );
}

}