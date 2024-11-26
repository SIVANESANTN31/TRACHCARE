// // import "package:flutter/material.dart";
// // import "package:google_fonts/google_fonts.dart";
// // import "package:sizer/sizer.dart";
// // import "package:trachcare/components/NAppbar.dart";
// // import "package:trachcare/style/colors.dart";

// // import "../../../../style/utils/Dimention.dart";

// // class AudioScreen extends StatelessWidget {
// //   const AudioScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // final orientation = MediaQuery.of(context).orientation;

// //     List words = [
// //       "YES",
// //       "NO",
// //       "WATER",
// //       "HELP",
// //       "YES",
// //       "NO",
// //       "WATER",
// //       "HELP",
// //       "YES",
// //       "NO",
// //       "WATER",
// //       "HELP"
// //     ];
// //     List colour = [
// //       const Color(0XFF82FF87),
// //       const Color(0XFFFB8A72),
// //       const Color(0XFFA8ECE8),
// //       const Color(0XFFEEECFF),
// //       const Color(0XFF82FF87),
// //       const Color(0XFFFB8A72),
// //       const Color(0XFFA8ECE8),
// //       const Color(0XFFEEECFF),
// //       const Color(0XFF82FF87),
// //       const Color(0XFFFB8A72),
// //       const Color(0XFFA8ECE8),
// //       const Color(0XFFEEECFF)
// //     ];
// //     Dimentions dn = Dimentions(context);
// //     return Scaffold(
// //       appBar: NormalAppbar(
// //         Title: "Tap To Speak",
// //         height: dn.height(15),
// //         actionbutton: IconButton(
// //             onPressed: () {},
// //             icon: const Icon(
// //               Icons.translate,
// //               color: whiteColor,
// //               size: 28,
// //             )), onTap: null,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           // mainAxisAlignment: MainAxisAlignment.center ,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.only(left: 8, top: 6),
// //               child: Container(
// //                 // alignment: Alignment.center,
// //                 width: 95.w,
// //                 height: 62.h,
// //                 decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(15),
// //                     border: Border.all(color: BlackColor),
// //                     color: whiteColor),
// //                 child: GridView.builder(
// //                   itemCount: 12,
// //                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisCount: 3,
// //                       mainAxisSpacing: 6,
// //                       crossAxisSpacing: 2),
// //                   itemBuilder: (BuildContext context, int index) {
// //                     return Padding(
// //                         padding: const EdgeInsets.all(9.0),
// //                         child: Helpercontainer(words[index], colour[index]));
// //                   },
// //                 ),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.only(left: 8, top: 8),
// //               child: Container(
// //                 // alignment: Alignment.center,
// //                 width: 95.w,
// //                 height: 9.h,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(15),
// //                   color: TitleColor
// //                 ),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   children: [
// //                     SizedBox(width: 60.w, height: 6.h, child: TextField(
// //                       decoration: InputDecoration(
// //                         hintText: "Type word to speak",
// //                         filled: true,
// //                         fillColor: whiteColor,
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(10))
// //                       ),
// //                     )),
// //                     Container(
// //                       width: 20.w,
// //                       height: 6.h,
// //                       alignment: Alignment.center,
// //                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: loginFormcolor),
// //                       child: Text("Speak",
// //                       //textAlign: TextAlign.center,
// //                       style: GoogleFonts.ibmPlexSans(
// //                         textStyle: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           color: whiteColor,
// //                             fontSize: 13.sp)),),
// //                     )
                   
// //                   ],
// //                 ),
// //               ),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget Helpercontainer(String text, Color colour) {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Container(
// //         alignment: Alignment.center,
// //         width: 18.w,
// //         height: 8.h,
// //         decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(10),
// //             color: colour,
// //             boxShadow: const [
// //               BoxShadow(
// //                 color: BlackColor_light,
// //                 blurRadius: 4.0,
// //               ),
// //             ]),
// //         child: Text(
// //           text,
// //           textAlign: TextAlign.center,
// //           style: GoogleFonts.ibmPlexSans(
// //               textStyle:
// //                   TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:sizer/sizer.dart';
// import 'package:trachcare/Api/API_funcation/DashboardApi.dart';
// import 'package:trachcare/Api/DataStore/Datastore.dart';
// import 'package:trachcare/components/Appbar.dart';  
// import 'package:trachcare/components/Navbardrawer.dart';
// import 'package:trachcare/components/Spigottingsheet.dart';
// import 'package:trachcare/style/colors.dart';
// import '../../../../Api/API_funcation/VideoApi.dart';
// import '../../../../Api/Apiurl.dart';
// import '../../../../style/utils/Dimention.dart';
// import '../patientscreens/patientprofile.dart';
// import 'dart:async';

// import 'VideoPlayer_screen.dart';
// class PatientDashBoard extends StatefulWidget {
//    const PatientDashBoard({super.key});

//   @override
//   State<PatientDashBoard> createState() => _PatientDashBoardState();
// }

// class _PatientDashBoardState extends State<PatientDashBoard> {

//    bool isLoading = true;
//    List Videourls = [];

//   Future FetchVideos() async {
//     Videourls = await Video().Fetchvideo();
//     return Videourls;
//   }

  
//   Future<void> onRefresh() async {
//     await Future.delayed(Duration(milliseconds: 1000));
//     await FetchVideos();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     FetchVideos();
//   }
//   @override
//   Widget build(BuildContext context) {
// List<String> notificationlist = [];

// void check_status(var status) {

//   TimeOfDay curtime = TimeOfDay.now(); // Get the current time
//   int currentHour = curtime.hour; // Get the current hour in 24-hour format

//   // Check if the status at 10 AM is null and current time is between 10 AM and 12 PM
//   if (status['status_10'] == "0" && currentHour >= 10 && currentHour < 12) {
//     notificationlist.add("10 AM");
//   }
//   // Check if the status at 12 PM is null and current time is between 12 PM and 2 PM (until 1:59 PM)
//   else if (status['status_12'] == "0" && currentHour >= 12 && currentHour < 14) {
//     notificationlist.add("12 PM");
//   }
//    else if (status['status_2'] == "0" && currentHour >= 14 && currentHour < 16) {
//     notificationlist.add("2 PM");
//   }
//   else if (status['status_4'] == "0" && currentHour >= 16 && currentHour < 18) {
//     notificationlist.add("4 PM");
//   }
//   else if (status['status_6'] == "0" && currentHour >= 18 && currentHour < 20) {
//     notificationlist.add("6 PM");
//   }
//   else{
    
//   }

// print(notificationlist.isNotEmpty);

// }


// Future<void> onRefresh() async{
//   await Future.delayed(Duration(milliseconds: 1000));
  
//   setState(() {
    
//   });
// }

//     print(patient_id);
//     // var currentIndex = 0;
//     List<String> imagelist = ["assets/images/Images_1.png","assets/images/images_2.png","assets/images/Images_3.png"];

//     return FutureBuilder(
//       future: PatientDashBoardApi().FetchDetials(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        
//         if(snapshot.connectionState == ConnectionState.waiting){
//           return const Center(child: CupertinoActivityIndicator(radius: 10,),);
//         }
//         if(snapshot.connectionState == ConnectionState.done){
//           if(snapshot.hasData){
//             print(snapshot.data);
//             var patientDetials = snapshot.data['Dashboard'];
//             var status = snapshot.data['status'];
//            check_status(status);
          
          
//             var name  = patientDetials['username'].toString();
//             var patient_id = patientDetials['patient_id'].toString();
//             var imagepath = patientDetials["image_path"].toString().substring(2);

//             Dimentions dn = Dimentions(context);

//             return Scaffold(
//               appBar: Appbar(Name:name, height: dn.height(10), notification: notificationlist.isNotEmpty,notificationlists:notificationlist),
//               drawer: drawer(Name: name,
//           reg_no: patient_id,
//           imagepath: NetworkImage("https://$ip/Trachcare/$imagepath"), onTap: (){
//         Navigator.of(context).push(MaterialPageRoute(
//                                builder: (context) => p_ProfilePage(),),);},),
       
//               body: RefreshIndicator.adaptive(
//                 onRefresh: onRefresh,
//                 color: CupertinoColors.systemBlue,
//                 child: Container(
//                   child: Stack(
//                     // crossAxisAlignment: CrossAxisAlignment.start,
                   
//                     children: [
//                       Gap(3.h),
//                       Positioned(
//                                 top: 500.0, // Position from the top of the screen
//                                 left: 25.0, // Position from the left of the screen
//                                 right: 25.0, 
//                                // width: dn.width(50),// Position from the right of the screen
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                                   child: Container(
//                                                   width: dn.width(90),
//                                                   height: dn.height(20),
                                                    
//                                                   decoration: BoxDecoration(
//                                                     color: whiteColor,
//                                                     borderRadius: BorderRadius.circular(10),
//                                                     boxShadow: const [
//                                                       BoxShadow(
//                                                      color: BlackColor_light,
//                                                       blurRadius: 4.0,
//                                                      ),
//                                                     ]
//                                                   ),
//                                                   child: Column(
//                                                     children: [
//                                                       Padding(
//                                                         padding: const EdgeInsets.all(8.0),
//                                                         child: Text("Spigotting Status : How long the patient can able to breath ?",textAlign: TextAlign.justify,style: GoogleFonts.ibmPlexSans(
//                                                             textStyle: TextStyle(
//                                   fontSize: 13.sp,))
//                                           ,),
//                                                       ),
                                                    
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           circleButton("10 am", context, status['status_10'] == '1' ? true : false, 10),
//                           circleButton("12 pm", context, status['status_12'] == '1' ? true : false, 12),
//                           circleButton("2 pm", context, status['status_2'] == '1' ? true : false, 14),
//                           circleButton("4 pm", context, status['status_4'] == '1' ? true : false, 16),
//                           circleButton("6 pm", context, status['status_6'] == '1' ? true : false, 18),
//                         ],
//                       )
                                                      
                                  
                                  
//                                                     ],
//                                                   )
//                                   ),
//                                 ),
//                             ),
//                             Gap(3.h),
                   
//                       Gap(3.5.h),
//                       Padding(
//                         padding: const EdgeInsets.all(9.0),
//                         child: Text("Exercisers For TrachCare:", style: GoogleFonts.ibmPlexSans(
//                           textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: const Color(0XFF455A64)))),
//                       ),
                     
                      
//                       carsouleview(imagelist,context)
//                     ],
//                   ),
//                 ),
//               )
//             );
//           }
//         }
//         return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/error.gif', // Change this path if necessary
//             height: 100,
//             width: 100,
//           ),
//           const SizedBox(height: 20),
//           const Text("No data available"),
//         ],
//       ),
//     );
//       }
//     );

    
//   }

// void popsheet(BuildContext context){
  
//        showCupertinoModalBottomSheet(
//       isDismissible: true,
//       enableDrag: true,
//       expand: false,
//       backgroundColor: Colors.transparent, context: context,
//       //duration: Duration(milliseconds: 500),
//       builder: (context) => Container(
//         width: 100.w,
//         height: 60.h,
//         child: Spigottingsheet(),
        
//        )
//       );
//     // );
//   }



// Widget circleButton(String time, BuildContext context, bool attendedStatus, int allowedHour) {
//   return Column(
//     children: [
//       GestureDetector(
//         onTap: () {
//           // Get current time hour
//           int currentHour = DateTime.now().hour;

//           if (currentHour >= allowedHour && currentHour < allowedHour+2 && attendedStatus == false) {
//             popsheet(context);
//           } else {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text("Session Unavailabe"),
//                   content: Text("This session is unavailable at time!."),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text("OK"),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//         child: Padding(
//           padding: EdgeInsets.all(4.0),
//           child: attendedStatus
//               ? CircleAvatar(
//                   child: Icon(
//                     CupertinoIcons.checkmark_alt,
//                     color: Colors.white,
//                   ),
//                   backgroundColor: CupertinoColors.systemGreen,
//                 )
//               : CircleAvatar(
//                   backgroundColor: CupertinoColors.tertiaryLabel,
//                   child: Icon(
//                     CupertinoIcons.circle_fill,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//         ),
//       ),
//       Text(time),
//     ],
//   );
// }

// Widget Helpercontainer(String text,Color colour,final buttonfuncation){
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: GestureDetector(
//       onTap: buttonfuncation,
//       child: Container(
//         alignment: Alignment.center,
//         width: 18.w,
//         height: 8.h,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
//         color: colour,
//         boxShadow: const [
//                       BoxShadow(
//               color: BlackColor_light,
//               blurRadius: 4.0,
//             ),
//                     ]
//         ),
//         child: Text(text ,textAlign: TextAlign.center,style: GoogleFonts.ibmPlexSans(
//                           textStyle: TextStyle(
                            
//                             fontWeight: FontWeight.bold,
//                               fontSize: 13.sp)),),
      
//       ),
//     ),
//   );
// }




// Widget carsouleview(List imagesList, BuildContext context) {
//   Dimentions dn = Dimentions(context);
//   final PageController pageController = PageController();
//   Timer? carouselTimer;

//   // Set up the timer for automatic scrolling
//   void startAutoScroll() {
//     carouselTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (pageController.hasClients) {
//         int nextPage = pageController.page!.toInt() + 1;
//         if (nextPage >= imagesList.length) {
//           nextPage = 0; 
//         }
//         pageController.animateToPage(
//           nextPage,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeIn,
//         );
//       }
//     });
//   }

//   // Stop the timer when the widget is disposed
//   @override
//   void dispose() {
//     carouselTimer?.cancel();
//     pageController.dispose();
//     super.dispose();
//   }

//   // Start the auto-scrolling when the widget is initialized
//   @override
//   void initState() {
//     super.initState();
//     startAutoScroll();
//   }

//   return SizedBox(
//     width: dn.width(130),
//     height: dn.height(45),
//     child: FutureBuilder(
//       future: FetchVideos(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CupertinoActivityIndicator(radius: 12),
//           );
//         } else if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             print("Error: ${snapshot.error}");
//             return const Center(child: Text("Failed to load videos!"));
//           } else if (snapshot.hasData && snapshot.data != null) {
//             List data = snapshot.data;
//             if (data.isEmpty) {
//               return const Center(child: Text("No videos available"));
//             } else {
//               return PageView.builder(
//                 controller: pageController,
//                 itemCount: data.length < 3 ? data.length : 3,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => video_player(
//                             Videoulrl: data[index]["Video_url"]?.toString() ?? "",
//                             description: data[index]["description"]?.toString() ?? "",
//                             title: data[index]["title"]?.toString() ?? "",
//                           ),
//                         ),
//                       );
//                     },
//                     child: SizedBox(
//                       width: dn.width(100),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SizedBox(
//                               height: dn.height(30),
//                               width: double.infinity,
//                               child: Image.network(
//                                 'https://$ip/Trachcare/${data[index]["Thumbnail_url"]?.toString().substring(2) ?? ""}',
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               data[index]["title"]?.toString() ?? "Untitled",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const Divider(),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           } else {
//             return const Center(child: Text("No videos available"));
//           }
//         }

//         return const Center(child: Text("Something went wrong!!!"));
//       },
//     ),
//   );
// }

// }

