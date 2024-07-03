// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:sizer/sizer.dart';
// import 'package:trachcare/Api/API_funcation/Login.dart';
// import 'package:trachcare/Api/DataStore/Datastore.dart';
// import 'package:trachcare/Screens/Views/Doctor/Bottomnavigator/Addpatients.dart';
// import 'package:trachcare/components/Titlebox.dart';
// import 'package:trachcare/components/story_circles.dart';
// import 'package:trachcare/components/subhead.dart';
// import "package:trachcare/components/custom_button.dart";
// import 'package:trachcare/Screens/Views/Doctor/Bottomnavigator/Doctordb.dart';
// import 'package:trachcare/style/colors.dart';
// import "package:trachcare/components/Appbar.dart";  
// import "package:trachcare/components/Navbardrawer.dart";


// class Doctordashboard extends StatelessWidget {
//       Doctordashboard({super.key});
//   //  void _openStory() {
//   //   Navigator.push(
//   //     context, 
//   //     MaterialPageRoute(
//   //       builder: (context) => StoryPage(),
//   //    ));
//   // }

//   List imgList = [
//     'Vector',
//     'Vector-1',
//     'Vector-2',
//     'video.fill.badge.plus'

//   ];
  
//   @override
//   Widget build(BuildContext context) {
//     var currentIndex = 0;
//    return Scaffold(
//       body: ListView(
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
//             decoration: BoxDecoration(
//               color: TitleColor,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               )
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                   Icon(
//                     Icons.menu_open_outlined,
//                     size: 35,
//                     color: Colors.white,
//                   ),
//                   Padding(padding: EdgeInsets.only(left: 3, bottom: 10,top: 20),
//                 child: Text("Hi, Sivanesan",
//                 style: TextStyle(
//                   fontSize: 25,fontWeight: FontWeight.w600,
//                   letterSpacing: 1,wordSpacing: 2, color: Colors.white,
//                   ),),
//                 ),
//                   Icon(
//                     Icons.notifications,
//                     size: 35,
//                     color: Colors.white,
//                   ),
//                   ]
//                 ),
//                 SizedBox(height: 10),
                
//                 Container(
//                   margin: EdgeInsets.only(top: 5, bottom: 45,),
//                   width: MediaQuery.of(context).size.width,
//                   height: 55,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Search here....",
//                       hintStyle: TextStyle(
//                         color: Colors.black.withOpacity(0.5),
//                       ),
//                       prefixIcon: Icon(Icons.search,size: 25,),
//                     ),
//                   )  
//                 ),
//               ], //children 
//             ),
//           ),
//           SizedBox(
//                   height: 100,
//                   child: ListView.builder(itemCount: 7,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return StoryCircles(
//                       // function: _openStory,
//                     );
//                    },
//                   ),
//                 ),
//                 // const Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //   children: [
//                 //     Text(
//                 //       "Records"
//                 //       style: TextStyle(
//                 //         fontSize:  23,
//                 //         fontWeight: FontWeight.w600,
//                 //       ),),
//                 //   ],),
//                   SizedBox(height: 10,),
//                   GridView.builder(
//                     itemCount: imgList.length,
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
//                     childAspectRatio: (MediaQuery.of(context).size.height - 40 - 20)/ (4*200),
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     ),
//                     itemBuilder: (context, index){
//                       return InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) => Addpatients(),)
//                             );
//                         },
//                         child: Container(
//                           padding: 
//                           EdgeInsets.symmetric(vertical: 20, horizontal:  10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Color.fromARGB(255, 226, 195, 129)
//                           ),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(10),
//                                 child: Image.asset("assets/images/${imgList[index]}.png", width: 50, height: 50,),),
//                                 SizedBox(height: 10,),
//                                 Text(
//                                   imgList[index],
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black.withOpacity(0.5),
//                                   ),
//                                 )
                            
//                           ],),
//                         ),

//                       );
//                     },
//                     ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         showSelectedLabels: true,
//         iconSize: 18,
//         selectedItemColor: Color.fromARGB(255, 95, 95, 95),
//         selectedFontSize: 18,
//         unselectedItemColor: Color.fromARGB(255, 194, 194, 194),
        
//         items: const [
//           BottomNavigationBarItem(
//             label: "Home",
//             icon: Icon(Icons.home),
//             ), 
//             BottomNavigationBarItem(
//             label: "Add Patients",
//             icon: Icon(Icons.person),
//             ),
//              BottomNavigationBarItem(
//             label: "Patients List",
//             icon: Icon(Icons.person),
//             ),
//         ],
//       ),
//     ); 
//   }
// }