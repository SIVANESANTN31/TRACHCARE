import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/Patientsdetails.dart';
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/dailyupdatedetails%20copy.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';


class d_CalendarScreen extends StatefulWidget {
  final String patientId;
  final String name;
  final String imagePath;

  const d_CalendarScreen({
    Key? key,
    required this.patientId,
    required this.name,
    required this.imagePath,
  }) : super(key: key);

  @override
  _d_CalendarScreenState createState() => _d_CalendarScreenState();
}

class _d_CalendarScreenState extends State<d_CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedDate = selectedDay;
      focusedDate = focusedDay;
      // Navigate to view daily updates page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => d_Viewdailyupdates(
            selecteddate: selectedDate.toString().substring(2).split(" ").first,
            patientId: widget.patientId,
            imagePath: widget.imagePath,
            name: widget.name,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar:  NormalAppbar(
        Title: "Daily Queries Reports",
        height: dn.height(10),
        onTap: () {
         Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => PatientDetails(patientId: widget.patientId,),));
        },
      ),
        body: ListView(
          children: [
            SizedBox(height: dn.height(5)),
            Namecard(widget.name, widget.patientId, widget.imagePath, context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: dn.width(5)),
              child: TableCalendar(
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
          backgroundImage: NetworkImage("https://$ip/Trachcare/${imagePath.toString().substring(2)}"),
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
