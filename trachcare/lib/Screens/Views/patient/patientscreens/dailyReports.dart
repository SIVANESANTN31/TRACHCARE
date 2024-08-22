import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/patient/patientscreens/dailyupdates.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:trachcare/style/colors.dart';

import '../../../../style/utils/Dimention.dart';


class YourdailyReports extends StatelessWidget {
  const YourdailyReports({super.key});

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: "YOUR DAILY RECORDS",height: dn.height(10),),
      body:  Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          child: CupertinoSearchTextField(),

        ),
         Expanded(
           child: ListView.builder(
            itemCount: 10,
             itemBuilder: (BuildContext context, int index) {
           
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: GestureDetector(
                  onTap: (){
                    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => your_daily_updates()));
                  },
                  child: NameCard("Siva", "3", "26/08/2003")),
               );
             }
           
           ),
         )

       
        
        




      ],),
    );
  }
}


Widget NameCard(String name, String patient_id ,String Dob){

  return Container( 
    width: 88.w,
    height: 15.h,
    decoration: BoxDecoration(border: Border.all(color: BlackColor,width: 1),
    borderRadius: BorderRadius.circular(15),
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
                            fontSize: 13.sp)),),
        Text("Date",style: GoogleFonts.ibmPlexSans(
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
                            fontSize: 13.sp)),),
        Text(Dob,style: GoogleFonts.ibmPlexSans(
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

