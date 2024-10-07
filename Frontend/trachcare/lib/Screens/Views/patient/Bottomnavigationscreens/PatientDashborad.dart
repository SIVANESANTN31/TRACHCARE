import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/API_funcation/DashboardApi.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/components/Appbar.dart';  
import 'package:trachcare/components/Navbardrawer.dart';
import 'package:trachcare/style/colors.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../style/utils/Dimention.dart';

class PatientDashBoard extends StatelessWidget {
  const PatientDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
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
            var patientDetials = snapshot.data;
            var name  = patientDetials['username'].toString();
            var imagepath = patientDetials["image_path"].toString().substring(2);

            Dimentions dn = Dimentions(context);

            return Scaffold(
              appBar: Appbar(Name:name, height: dn.height(10)),
              drawer: drawer(Name: name,
             
          reg_no: 'regno',imagepath: NetworkImage("https://$ip/Trachcare/$imagepath"),),
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
                      circleButton("9 am"),
                      circleButton("9 am"),
                      circleButton("9 am"),
                      circleButton("9 am"),
                      circleButton("9 am")
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
