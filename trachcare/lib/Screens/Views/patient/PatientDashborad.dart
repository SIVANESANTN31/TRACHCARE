import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/components/Appbar.dart";  
import "package:trachcare/components/Navbardrawer.dart";
import "package:trachcare/style/colors.dart";

import "../../../style/Tropography.dart";

class PatientDashBoard extends StatelessWidget {
  const PatientDashBoard({super.key});
  @override
  Widget build(BuildContext context) {

        var currentIndex = 0;
    List imagelist = ["assets/images/Images_1.png","assets/images/images_2.png","assets/images/Images_3.png"];
    return Scaffold(
      appBar: Appbar(Name: "sivanesan",bottom: Bottom(),),
       drawer: drawer(),
    
      
      body: Column(
       
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(3.h),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              width: 95.w,
              height: 10.h,
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(15)),
      
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text("Next Appointment Date to conseil is",style: GoogleFonts.ibmPlexSans(
                    textStyle: TextStyle(
                        fontSize: 10.sp)),),
                  
                Container(
                  width: 20.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    border: Border.all(),borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text(" Aug 15")),
                )
              ],),
            ),
          ),
          
          Gap(3.5.h),
      
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text("Exercisers For Trach Care :",style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(
                      
                          fontSize: 15.sp,fontWeight: FontWeight.bold,color: Color(0XFF455A64)),)),
          ),
        carsouleview(imagelist),
        Gap(1.h),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TaptoSpeak(),
        )

          
        ],
      ),

      );

  }




PreferredSizeWidget Bottom(){
  return PreferredSize(
       preferredSize: Size.fromHeight(30.0),
       child: Positioned(
              top: 0.0, // Position from the top of the screen
              left: 25.0, // Position from the left of the screen
              right: 25.0, // Position from the right of the screen
              child: Container(
                height: 16.h,
                width: 97.w,
              
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
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
     );
}


Widget circleButton(String time,){
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          backgroundColor: admin_color,
        ),
      ),
      Text(time)
    ],
  );
}

Widget carsouleview(List Imageslist){
  return  Container(
        width: 100.w,
        height: 20.h,
        // decoration: BoxDecoration(
        //   image: DecorationImage(image: AssetImage(imagelist[index]),
        // ),
        child: CarouselSlider(
      options: CarouselOptions(),
      items: Imageslist
          .map((item) => Container(
                child: Center(
                    child:
                        Image.asset(item, fit: BoxFit.cover, width: 1000)),
              ))
          .toList(),
      ));

}


Widget TaptoSpeak(){
  return Container(
    width: 95.w,
    height: 18.h,
    decoration: BoxDecoration(gradient: maincolor ,borderRadius: BorderRadius.circular(15)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 45.w,
          height: 6.h,
          //color: BlackColor,

           decoration: BoxDecoration(color: whiteColor ,borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 10.w,
                height: 4.h,
                child: Image.asset("assets/images/Vector.png"),
              ),
              Text("Tap to Speak",style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 13.sp)),)
            ],
        )),
      ),
      
      Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[ Helpercontainer("YES",Color(0XFF82FF87)) ,
      Helpercontainer("NO",Color(0XFFFB8A72)),
      Helpercontainer("Help",Color(0XFFA8ECE8)),
      Helpercontainer("More words",Color(0XFFEEECFF))

      ])
    ],),
  );
}


Widget Helpercontainer(String text,Color colour){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      alignment: Alignment.center,
      width: 18.w,
      height: 8.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      color: colour,
      boxShadow: [
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
  );
}



}