import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Screens/Views/patient/Bottomnavigationscreens/AudioScreen.dart";
import "package:trachcare/components/Appbar.dart";  
import "package:trachcare/components/Navbardrawer.dart";
import "package:trachcare/style/colors.dart";

import "../../../../../style/Tropography.dart";
import "../../../../components/story_circles.dart";
import "Addpatients.dart";

class DoctorDashBoard extends StatelessWidget {
       DoctorDashBoard({super.key});

  List imgList = [
    'Vector',
    'Vector-1',
    'Vector-2',
    'video.fill.badge.plus'

  ];
  List option = [
    'Add new words to speak',
    'Add new Patient',
    'Add new Surgical videos',
    'Add new execerise videos'
  ];

  
  @override
  Widget build(BuildContext context) {

        var currentIndex = 0;
    List imagelist = ["assets/images/Images_1.png","assets/images/images_2.png","assets/images/Images_3.png"];
    return Scaffold(
      appBar: Appbar(Name: "sivanesan",bottom: Bottom(context), height: 35.h,),
       drawer: drawer(),
      
      body: ListView(
        children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: imgList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      childAspectRatio: (MediaQuery.of(context).size.height - 40 - 20)/ (4*175),
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Addpatients(),)
                              );
                          },
                          child: Container(
                            padding: 
                            EdgeInsets.symmetric(vertical: 20, horizontal:  10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 226, 195, 129),
                              boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3))],
                            
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset("assets/images/${imgList[index]}.png", width: 50, height: 50,),),
                                  SizedBox(height: 10,),
                                  Text(
                                    option[index],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.50),
                                    ),
                                  )
                              
                            ],),
                          ),
                    
                        );
                      },
                      ),
                  ),
         
        //  crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Gap(1.h),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 10.0),
        //       child: Container(
        //         width: 95.w,
        //         height: 10.h,
        //         decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(15)),
        
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //           Text("Next Appointment Date to conseil is",style: GoogleFonts.ibmPlexSans(
        //               textStyle: TextStyle(
        //                   fontSize: 10.sp)),),
                    
        //           Container(
        //             width: 20.w,
        //             height: 6.h,
        //             decoration: BoxDecoration(
        //               border: Border.all(),borderRadius: BorderRadius.circular(10)
        //             ),
        //             child: Center(child: Text(" Aug 15")),
        //           )
        //         ],),
        //       ),
        //     ),
            
        //     Gap(3.5.h),
        
        //     Padding(
        //       padding: const EdgeInsets.all(9.0),
        //       child: Text("Exercisers For Trach Care :",style: GoogleFonts.ibmPlexSans(
        //                 textStyle: TextStyle(
                        
        //                     fontSize: 15.sp,fontWeight: FontWeight.bold,color: Color(0XFF455A64)),)),
        //     ),
        //   carsouleview(imagelist),
        //   Gap(1.h),
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: TaptoSpeak(context),
        //   )
        
            
        //   ],
        ]
        ),
      );

  }




PreferredSizeWidget Bottom(BuildContext context){
  return PreferredSize(
       preferredSize: Size.fromHeight(20.0),
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 0),
             child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 25,),
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.15),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))],
                        ),
                        
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here....",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            
                            prefixIcon: Icon(Icons.search,size: 25,),
                          ),
                        )  
                      ),
           ),
          //  SizedBox(height: 10),
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Container(
              decoration: BoxDecoration(
                          color: Color.fromARGB(255, 177, 255, 183),
                          borderRadius: BorderRadius.circular(10),
                        ),
                    height: 100,
                    child: ListView.builder(itemCount: 15,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return StoryCircles(
                        // function: _openStory,
                      );
                     },
                    ),
                  ),
           ),

         ],
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


Widget TaptoSpeak(BuildContext context){
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
        children:[ Helpercontainer("YES",Color(0XFF82FF87),(){}) ,
      Helpercontainer("NO",Color(0XFFFB8A72),(){}),
      Helpercontainer("Help",Color(0XFFA8ECE8),(){}),
      Helpercontainer("More words",Color(0XFFEEECFF),(){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AudioScreen()));
      })

      ])
    ],),
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
    ),
  );
}



}