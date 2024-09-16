import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Screens/Views/patient/patientscreens/dailyupdates.dart";
import "package:trachcare/components/NAppbar.dart";
import "package:trachcare/style/colors.dart";

import "../../../../style/utils/Dimention.dart";
import "../patientscreens/dailyReports.dart";

class MedicationPage extends StatelessWidget {
  const MedicationPage({super.key});







  @override
  Widget build(BuildContext context) {

    void daily_updates(){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const your_daily_updates()));
}



void daily_Reports(){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const YourdailyReports()));

}
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(
        
        Title: "Diagnostics",
        height: dn.height(15),
      ),
      body: Column(
        children: [

          // Image container


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(width: double.infinity,
            height: 45.h,
            decoration: const BoxDecoration(
             
              image: DecorationImage(image: AssetImage("assets/images/D1.png")))
            ),
          ),


          //Reports containers 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    daily_updates();
                  },
                  child: Container(width: 42.w,height: 20.h,
                  
                  decoration: BoxDecoration(color: loginFormcolor,borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.25),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3))]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 50,bottom: 20),
                        child: Icon(Icons.history,size: 50,color: whiteColor,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Update your Daily Reports",textAlign:TextAlign.start,
                        
                        style: GoogleFonts.ibmPlexSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                                fontSize: 13.sp)),),
                      )
                  
                  ],),
                  
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),


                child: GestureDetector(
                  onTap: (){
                    daily_Reports();
                  },
                  child: Container(width: 42.w,height: 20.h, 
                  
                  decoration: BoxDecoration(color: loginFormcolor,
                  borderRadius: BorderRadius.circular(15)
                  ,boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.25),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3))]
                  
                  ),
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 50,bottom: 20),
                        child: Icon(Icons.calendar_today_rounded,size: 50,color: whiteColor,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Records of your Daily Reports",textAlign:TextAlign.start,
                        
                        style: GoogleFonts.ibmPlexSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                                fontSize: 13.sp)),),
                      )
                  
                  ],
                  
                  
                  
                  ),
                                ),
                )
           ) ],
          )
        ],
      ),
    );
  }
}
