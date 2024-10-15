import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/API_funcation/DashboardApi.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/components/Appbar.dart';  
import 'package:trachcare/components/Navbardrawer.dart';
import 'package:trachcare/components/Spigottingsheet.dart';
import 'package:trachcare/style/colors.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../style/utils/Dimention.dart';
import '../patientscreens/patientprofile.dart';

class PatientDashBoard extends StatelessWidget {
   const PatientDashBoard({super.key});







  @override
  Widget build(BuildContext context) {
List<String> notificationlist = [];

void check_status(var status) {
  TimeOfDay curtime = TimeOfDay.now(); // Get the current time
  int currentHour = curtime.hour; // Get the current hour in 24-hour format

  // Check if the status at 10 AM is null and current time is between 10 AM and 12 PM
  if (status['status_10'] == "0" && currentHour >= 10 && currentHour < 12) {
    notificationlist.add("10 AM");
  }
  // Check if the status at 12 PM is null and current time is between 12 PM and 2 PM (until 1:59 PM)
  else if (status['status_12'] == "0" && currentHour >= 12 && currentHour < 14) {
    notificationlist.add("12 PM");
  }
   else if (status['status_2'] == "0" && currentHour >= 14 && currentHour < 16) {
    notificationlist.add("2 PM");
  }
  else if (status['status_4'] == "0" && currentHour >= 16 && currentHour < 18) {
    notificationlist.add("4 PM");
  }
  else if (status['status_6'] == "0" && currentHour >= 18 && currentHour < 20) {
    notificationlist.add("6 PM");
  }
  else{
    
  }

print(notificationlist.isNotEmpty);

}



void popsheet(BuildContext context){
  
       showCupertinoModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      expand: false,
      backgroundColor: Colors.transparent, context: context,
      //duration: Duration(milliseconds: 500),
      builder: (context) => Container(
        width: 100.w,
        height: 60.h,
        child: Spigottingsheet(),
        
       )
      );
    // );
  }




    print(patient_id);
    var currentIndex = 0;
    List<String> imagelist = ["assets/images/Images_1.png","assets/images/images_2.png","assets/images/Images_3.png"];
    
    // Instantiate the CarouselController
    // final carousel.CarouselController controller = carousel.CarouselController();

    return FutureBuilder(
      future: PatientDashBoardApi().FetchDetials(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CupertinoActivityIndicator(radius: 10,),);
        }
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            var patientDetials = snapshot.data['Dashboard'];
            var status = snapshot.data['status'];
           check_status(status);
          
            var name  = patientDetials['username'].toString();
            var imagepath = patientDetials["image_path"].toString().substring(2);

            Dimentions dn = Dimentions(context);

            return Scaffold(
              appBar: Appbar(Name:name, height: dn.height(10), notification: notificationlist.isNotEmpty,notificationlists:notificationlist),
              drawer: drawer(Name: name,
          reg_no: 'regno',
          imagepath: NetworkImage("https://$ip/Trachcare/$imagepath"), onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) => p_ProfilePage(),),);},),
       
              body: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(3.h),
                    Positioned(
              top: 500.0, // Position from the top of the screen
              left: 25.0, // Position from the left of the screen
              right: 25.0, // Position from the right of the screen
              child: Container(
                width: dn.width(90),
                height: dn.height(20),
    
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                   color: BlackColor_light,
                    blurRadius: 4.0,
                   ),
                  ]
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Spigotting Status : How long the patient can able to breath ?",textAlign: TextAlign.justify,style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(
                              fontSize: 13.sp,))
                                      ,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      GestureDetector(
                        onTap: (){
                          popsheet(context);
                        },
                        child: circleButton("10 am")),
                      circleButton("12 pm"),
                      circleButton("2 pm"),
                      circleButton("4 pm"),
                      circleButton("6 pm")
                    ],)
                    


                  ],
                )
              ),
            ),
            Gap(3.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        width: dn.width(100),
                        height: dn.height(10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Next Appointment Date to conseil is", style: GoogleFonts.ibmPlexSans(
                              textStyle: TextStyle(fontSize: 10.sp))),
                            Container(
                              width: 20.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(child: Text(" Aug 15")),
                            )
                          ],
                        ),
                      ),
                    ),
                    Gap(3.5.h),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text("Exercisers For Trach Care:", style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: const Color(0XFF455A64)))),
                    ),
                   
                    
                    carsouleview(imagelist,context)
                  ],
                ),
              )
            );
          }
        }
        return const Center(child: Text("No data available"));
      }
    );

    
  }
  Widget carsouleview(List<String> imagesList,BuildContext context) {
    Dimentions dn = Dimentions(context);
    
    return SizedBox(
      width: dn.width(100),
      height: dn.height(17),
          child: 
                FlutterCarousel.builder(
                  itemCount:imagesList.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                 child: Stack(
                  alignment: material.Alignment.center,
                  children: [
                 
                 Center(child: Image.asset(imagesList[itemIndex], fit: BoxFit.cover, width: 1000)),
                    const CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.play_arrow,color: whiteColor,),
              )
                 
                 
                 ])), 
                 options:  CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayCurve: material.Curves.easeIn,
                  enableInfiniteScroll: true,
                 ),
    
                ),
             
          );
        
  }




Widget circleButton(String time,){
  return Column(
    children: [
      const Padding(
        padding: EdgeInsets.all(4.0),
        child: CircleAvatar(
          backgroundColor: admin_color,
        ),
      ),
      Text(time)
    ],
  );
}

Widget Helpercontainer(String text,Color colour,final buttonfuncation){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: buttonfuncation,
      child: Container(
        alignment: Alignment.center,
        width: 18.w,
        height: 8.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        color: colour,
        boxShadow: const [
                      BoxShadow(
              color: BlackColor_light,
              blurRadius: 4.0,
            ),
                    ]
        ),
        child: Text(text ,textAlign: TextAlign.center,style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(
                            
                            fontWeight: FontWeight.bold,
                              fontSize: 13.sp)),),
      
      ),
    ),
  );
}
}
