import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/Addvideos.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/patientslist.dart';
import "package:trachcare/components/Appbar.dart";
import '../../../../style/utils/Dimention.dart';
import '../Adminscreens/Doctorlist.dart'; 

class Admindb extends StatelessWidget {
   Admindb({super.key});

  List imgList = [
    'Vector',
    'Vector-1',
    'Vector-2',
    // 'video.fill.badge.plus',
    // 'Adddoctor',
    // 'Addpatients',
    // 'Doctor_list1',
    // '2',

  ];

  List pages_name = [
    'Doctors list',
    'Add videos',
    'Patients list',

  ];

  @override
  Widget build(BuildContext context) {

    List pages=[
       Doctorlist(),
       Addvideos(),
       patientslist(),
    ];
        Dimentions dn = new Dimentions(context);
    return Scaffold(
      appBar: Appbar(Name: "sivanesan", height: dn.height(12),),
      body: Stack(
      children: [
        // Background image with blur effect
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/5.png'), 
                
              ),
            ),
          ),
        ),
        
        // Scrollable content
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(16.0),
                color: Colors.white.withOpacity(0.8), // Semi-transparent background for the content
                child: Text(
                  'Your scrollable content goes here. ' * 1, // Example text
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10,),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: GridView.builder(
              //         padding: EdgeInsets.all(10),
              //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2, // Number of columns
              //           crossAxisSpacing: 10, // Space between columns
              //           mainAxisSpacing: 10, // Space between rows
              //           childAspectRatio: 1, // Aspect ratio of the items
              //         ),
              //         itemCount: imgList.length,
              //         itemBuilder: (context, index) {
              //           return Container(
              //             decoration: BoxDecoration(
              //               image: DecorationImage(
              //   image: AssetImage(imgList[index]), // Load images from assets
              //   fit: BoxFit.cover,
              //               ),
              //               borderRadius: BorderRadius.circular(10), // Optional: rounded corners
              //             ),
              //           );
              //         },
              //       ),
              // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: imgList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      childAspectRatio: (MediaQuery.of(context).size.height - 40 - 20)/ (4*175),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => pages[index],)
                              );
                          },
                          child: Container(
                            padding: 
                            EdgeInsets.symmetric(vertical: 20, horizontal:  10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [Color(0XFFFFD9A0), Color(0XFFFFEDD2)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                            ),
                            child: Column(
                              children: [
                                
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: 
                                  Image.asset("assets/images/${imgList[index]}.png", width: 70, height: 70,),),
                                  SizedBox(height: 20,),
                                  Text(
                                    pages_name[index],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  )
                              
                            ],),
                          ),
                    
                        );
                      },
                      ),
                  ),
              // Add more content as needed
            ],
          ),
        ),
      ],

    ),);
  }
}