import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trachcare/Api/API_funcation/PatientDashboard.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:trachcare/style/Tropography.dart';
import 'package:trachcare/style/colors.dart';

import '../../../../style/utils/Dimention.dart';


class YourdailyReports extends StatefulWidget {
  const YourdailyReports({super.key});

  @override
  State<YourdailyReports> createState() => _YourdailyReportsState();
}

class _YourdailyReportsState extends State<YourdailyReports> {
    DateTime _selectedDate = DateTime.now();

  DateTime _focusedDate = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
      _focusedDate = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: "YOUR DAILY RECORDS",height: dn.height(10),),
      body:  FutureBuilder(
        future: PatientDashBoardApi().FetchDetials(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
          if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CupertinoActivityIndicator(radius: 10,),);
        }
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            var patientDetials = snapshot.data;
            var name  = patientDetials['name'].toString();
            var patientId =  patientDetials['patient_id'].toString();
            var age = patientDetials['age'].toString();


               return Column(children: [
         
           
           Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 10),
                 child: NameCard(name, patientId, age),
               ),
                TableCalendar(
              availableGestures: AvailableGestures.all,
              pageJumpingEnabled: true,
              headerStyle:const HeaderStyle(formatButtonVisible: false,titleCentered: true,) ,
                focusedDay: _focusedDate,
                 firstDay: DateTime.utc(2010,1,1), 
                 lastDay: DateTime.now().add(
                  const Duration(days: 365),
                ),
                selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
          onDaySelected: _onDaySelected,
                
                )
        
          
          
        
         
          
          
        
        
        
        
        ],);}}
        return Text("Something Went Wrong!!!!",style: BoldStyle,);
  }),
    );
  }
}


Widget NameCard(String name, String patientId ,String Dob){

  return Container( 
    width: 88.w,
    height: 15.h,
    decoration: BoxDecoration(border: Border.all(color: BlackColor,width: 1),
    borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CircleAvatar(
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
      Text(patientId,style: GoogleFonts.ibmPlexSans(
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

