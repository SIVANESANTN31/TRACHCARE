import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/dailyupdatedetails.dart';
import 'package:trachcare/components/NAppbar.dart';

import '../../../../Api/DataStore/Datastore.dart';

import '../../../../style/colors.dart';

import '../../../../style/utils/Dimention.dart';


class DailyUpdatePatients extends StatefulWidget {
  const DailyUpdatePatients({super.key});

  @override
  State<DailyUpdatePatients> createState() => _DailyUpdatePatientsState();
}

class _DailyUpdatePatientsState extends State<DailyUpdatePatients> {
    get patientId => patient_id;

  @override
  Widget build(BuildContext context) {


      DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  print(selectedDate);

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedDate = selectedDay;
      focusedDate = focusedDay;
      
                     
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                            
                              builder: (context) =>  Viewdailyupdates(selecteddate: selectedDate.toString().split(" ").first )
                     ));
                  
    });
  }

    Dimentions dn = Dimentions(context);
    return Scaffold(
        appBar: NormalAppbar(Title: "Report", height: dn.height(15), onTap: null,),
        body: ListView(children: [
          Namecard(username, patient_id,context),
        //   TableCalendar(
        //     availableGestures: AvailableGestures.horizontalSwipe,
        //     pageJumpingEnabled: true,
        //     headerStyle:const HeaderStyle(formatButtonVisible: false,titleCentered: true,) ,
        //       focusedDay: focusedDate,
        //        firstDay:  DateTime(DateTime.now().year, DateTime.now().month, 1), 
               
               
        //        lastDay: DateTime.now(),
        //        enabledDayPredicate: (day) => day.isBefore(DateTime.now().add(Duration(days: 1))),
        //       calendarStyle:CalendarStyle(
        //         todayDecoration:BoxDecoration(gradient: maincolor)
        //       ),
  
        //       selectedDayPredicate: (day) => isSameDay(day, selectedDate),
        // onDaySelected: onDaySelected,
              
        //       )
        TableCalendar(
  availableGestures: AvailableGestures.horizontalSwipe,
  pageJumpingEnabled: true,
  headerStyle: const HeaderStyle(
    formatButtonVisible: false,
    titleCentered: true,
  ),
  focusedDay: focusedDate,
  firstDay: DateTime(DateTime.now().year, DateTime.now().month, 1),
  lastDay: DateTime.now(), // Last selectable day is today
  calendarStyle: CalendarStyle(
   
    disabledDecoration: BoxDecoration(
      color: Colors.grey.shade300, // Color for disabled (future) days
      shape: BoxShape.circle,
    ),
    disabledTextStyle: TextStyle(
      color: Colors.grey, // Text style for disabled days
    ),
  ),
  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
  
  // Disable selection for future days
  enabledDayPredicate: (day) => day.isBefore(DateTime.now().add(Duration(days: 1))),

  onDaySelected: (selectedDay, focusedDay) {
    if (selectedDay.isBefore(DateTime.now().add(Duration(days: 1)))) {
      // Call onDaySelected only if the selected day is not in the future
      onDaySelected(selectedDay, focusedDay);
    }
  },
)



        // SfCalendar(
        //   view: CalendarView.month,
        // )
        ])
        
        
        )
        
        
        
        ;

        
  }
}




Widget Namecard(String name, String patientId,BuildContext context) {
  Dimentions dn = Dimentions(context);
  return Container(
    margin: const EdgeInsets.all(10),
    width: double.infinity,
    height: dn.height(15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: BlackColor, width: 0.3)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CircleAvatar(
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
                      patientId,
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