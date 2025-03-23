import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/Medication.dart';
import 'package:trachcare/Screens/Views/patient/patientscreens/dailyReports.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';

class calender extends StatefulWidget {
  final String name;
  final String imagePath;

  const calender({
    Key? key,
    required this.name,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<calender> createState() => _calenderState();
}


class _calenderState extends State<calender> {
    DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  
  get patientId => patient_id;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedDate = selectedDay;
      focusedDate = focusedDay;
      // Navigate to view daily updates page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Viewdailyupdates(selecteddate: selectedDate.toString().split(" ").first, patientId: patientId, imagePath: widget.imagePath , name: widget.name,),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar:  NormalAppbar(
      Title: "Daily Queries Reports",
      height: dn.height(10),
      onTap: () {
      Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => MedicationPage()),(route)=>false);
      },
    ),
      body: ListView(
        children: [
          SizedBox(height: dn.height(5)),
          Namecard(widget.name, patientId, widget.imagePath, context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dn.width(5)),
            child:TableCalendar(
  availableGestures: AvailableGestures.horizontalSwipe,
  headerStyle: HeaderStyle(
    formatButtonVisible: false,
    titleCentered: true,
    titleTextStyle: GoogleFonts.ibmPlexSans(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black54),
    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black54),
  ),
  calendarStyle: CalendarStyle(
    todayDecoration: BoxDecoration(
      color: Colors.blueAccent.shade100,
      shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
      color: Colors.greenAccent.shade700,
      shape: BoxShape.circle,
    ),
    selectedTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    weekendTextStyle: TextStyle(color: Colors.redAccent),
    defaultTextStyle: TextStyle(color: Colors.black87),
    outsideTextStyle: TextStyle(color: Colors.grey.shade400),
    disabledDecoration: BoxDecoration(
      color: Colors.grey.shade300,
      shape: BoxShape.circle,
    ),
    disabledTextStyle: TextStyle(color: Colors.grey),
  ),
  focusedDay: focusedDate,
  firstDay: DateTime(2000, 1, 1), // Allows navigation from January 1st, 2000
  lastDay: DateTime(2100, 12, 31), // Allows navigation until December 31st, 2100
  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
  enabledDayPredicate: (day) => day.isBefore(DateTime.now().add(Duration(days: 1))),
  onDaySelected: (selectedDay, focusedDay) {
    if (selectedDay.isBefore(DateTime.now().add(Duration(days: 1)))) {
      onDaySelected(selectedDay, focusedDay);
    }
  },
)

          ),
        ],
      ),
    );
  }
}

Widget Namecard(String name, String patientId, String imagePath, BuildContext context) {
  Dimentions dn = Dimentions(context);
  return Container(
    margin: const EdgeInsets.all(10),
    width: double.infinity,
    height: dn.height(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
      border: Border.all(color: BlackColor, width: 0.3),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage("https://$ip/Trachcare/$imagePath"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  Text(
                    "Patient ID",
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(": ", style: GoogleFonts.ibmPlexSans(fontSize: 13.sp)),
                  Text(": ", style: GoogleFonts.ibmPlexSans(fontSize: 13.sp)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  Text(
                    patientId,
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
