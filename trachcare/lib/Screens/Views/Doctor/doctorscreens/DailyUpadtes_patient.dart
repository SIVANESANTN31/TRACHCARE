import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trachcare/components/NAppbar.dart';

import '../../../../style/colors.dart';
import 'package:intl/intl.dart';

class DailyUpdatePatients extends StatefulWidget {
  DailyUpdatePatients({super.key});

  @override
  State<DailyUpdatePatients> createState() => _DailyUpdatePatientsState();
}

class _DailyUpdatePatientsState extends State<DailyUpdatePatients> {
  @override
  Widget build(BuildContext context) {


     DateTime today = DateTime.now();
     DateTime?_selectedDate;
      void onDaySelected(DateTime day ,DateTime focusedDay){
       print(day);
          setState(() {
             today = day;
          });
         
          
        

     }


    return Scaffold(
        appBar: NormalAppbar(Title: "Report"),
        body: ListView(children: [
          Namecard("Siva", "132"),
          TableCalendar(
            availableGestures: AvailableGestures.all,
            pageJumpingEnabled: true,
            headerStyle:HeaderStyle(formatButtonVisible: false,titleCentered: true,) ,
              focusedDay: today,
               firstDay: DateTime.utc(2010,1,1), 
               lastDay: DateTime.now().add(
                Duration(days: 365),
              ),
              selectedDayPredicate: (day) =>isSameDay(day,today),

             onDaySelected: onDaySelected,
              
              )
        ]));

        
  }
}

Widget Namecard(String name, String patient_id) {
  return Container(
    margin: EdgeInsets.all(10),
    width: double.infinity,
    height: 12.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: BlackColor, width: 0.3)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          minRadius: 20,
          child: Image(image: AssetImage("assets/images/doctor.png")),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Name",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    ),
                    Text(
                      "Patient Id ",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      ":",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    ),
                    Text(
                      ": ",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    ),
                    Text(
                      patient_id,
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    )
                  ],
                )
              ],
            ))
      ],
    ),
  );
}
