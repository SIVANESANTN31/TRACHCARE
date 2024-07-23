import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/components/NAppbar.dart";
import "package:trachcare/style/colors.dart";

class your_daily_updates extends StatelessWidget {
  const your_daily_updates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(Title: "Your Daily Update"),
      body: ListView(
        
        children: [
          Namecard("siva", "12345"),
          
          Gap(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Text("Vitals",style:GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontSize: 13.sp))),
                Text("Respiratory Rate",

                
                textAlign: TextAlign.start,
                style:GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          
                            fontSize: 13.sp))),
                 Text("Heart Rate",
                 textAlign: TextAlign.start,
                 style:GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          
                            fontSize: 13.sp))),
                  Text("SPO2 @ Room Air",
                  textAlign: TextAlign.start,
                  style:GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          
                            fontSize: 13.sp))),
                  Text("Daily dressing done ?",
                  textAlign: TextAlign.start,
                  style:GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          
                            fontSize: 13.sp))),
                  Text("Trachestomy tie changed ?",
                  textAlign: TextAlign.start,
                  style:GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          
                            fontSize: 13.sp))),
                  Text("Suctioning done ?",
                  textAlign: TextAlign.start,
                  style:GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          
                            fontSize: 13.sp))),
                  Text("has the patient started on oral feeds ?",
                  textAlign: TextAlign.start,
                  style:GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          
                            fontSize: 13.sp))),
                  Text("has the patient been changed to green tube ?",
                  textAlign: TextAlign.start,
                  style:GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          
                            fontSize: 13.sp))),
              ],),
              Column(children: [
                //TextField(decoration: InputDecoration(hintText: "Values..",border: OutlineInputBorder(borderSide: BorderSide(color: BlackColor))),)
                Text("data")
              ],)

          ],)

      ],),
    );
  }
}

Widget Namecard(String name ,String patient_id){

      return Container(
            
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: 12.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: BlackColor,width: 0.3)
            ),
            child: Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  minRadius: 20,
                  child: Image(image: AssetImage("assets/images/doctor.png")),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
    children: [
      Column(
        children: [
          Text("Name",style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 13.sp)),),
      Text("Patient Id ",style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 13.sp)),)
        ],
      ),
      Column(
        children: [
          Text(":",style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 13.sp)),),
      Text(": ",style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 13.sp)),)
        ],
      ),
      Column(
        children: [
          Text(name,style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 13.sp)),),
      Text(patient_id,style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 13.sp)),)
        ],
      )
    ],
  )
                )
                


            ],),
          );



   

}