import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Screens/Views/patient/patientscreens/dailyupdates.dart";
import "package:trachcare/components/NAppbar.dart";
import "package:trachcare/style/colors.dart";

class MedicationPage extends StatelessWidget {
  const MedicationPage({super.key});







  @override
  Widget build(BuildContext context) {

    void daily_updates(){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>your_daily_updates()));
}
    return Scaffold(
      appBar: NormalAppbar(
        
        Title: "Diagnostics",
      ),
      body: Column(
        children: [

          // Image container


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(width: double.infinity,
            height: 45.h,
            decoration: BoxDecoration(
             
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
                              offset: Offset(0, 3))]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50,bottom: 20),
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
                child: Container(width: 42.w,height: 20.h, 
                
                decoration: BoxDecoration(color: loginFormcolor,
                borderRadius: BorderRadius.circular(15)
                ,boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3))]
                
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50,bottom: 20),
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
              )
           ) ],
          )
        ],
      ),
    );
  }
}
