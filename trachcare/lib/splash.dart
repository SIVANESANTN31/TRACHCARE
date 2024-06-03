// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_unnecessary_containers

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:trachcare/homepage.dart';

// class Splashscreen extends StatefulWidget {
//   const Splashscreen({super.key});

//   @override
//   State<Splashscreen> createState() => _SplashscreenState();
// }

// class _SplashscreenState extends State<Splashscreen> 
//     with SingleTickerProviderStateMixin{

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

//     Future.delayed(
//       Duration(seconds: 3),(){
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => const indexpage(),
//           ),
//         );
//       }
//     );
//   }
//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeigth = MediaQuery.of(context).size.height;
//     return  MaterialApp(
//       home: Container(
//     width: screenWidth * 0.25,
//     height: screenHeigth * 0.25,
//     clipBehavior: Clip.antiAlias,
//     decoration: BoxDecoration(
//         gradient: LinearGradient(
//             begin: Alignment(0.00, -1.00),
//             end: Alignment(0, 1),
//             colors: [Color.fromARGB(255, 255, 183, 183), Color.fromARGB(255, 191, 255, 255)],
//         ),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//                 Positioned(
//                     child: Container(
//                         width: screenWidth * 0.50,
//                         height: screenHeigth * 0.25,
//                         decoration: ShapeDecoration(
//                             image: DecorationImage(
//                                 image: AssetImage("assets/images/logo.jpeg"),
//                                 fit: BoxFit.fill,
//                             ),
//                             shape: OvalBorder(),
//                             shadows: [
//                                 BoxShadow(
//                                     color: Color(0x3F000000),
//                                     blurRadius: 4,
//                                     offset: Offset(0, 4),
//                                     spreadRadius: 0,
//                                 ),
//                                 BoxShadow(
//                             color: Color(0x3F000000),
//                             blurRadius: 4,
//                             offset: Offset(0, 4),
//                             spreadRadius: 0,
//                               ),
//                               BoxShadow(
//                             color: Color(0x3F000000),
//                             blurRadius: 4,
//                             offset: Offset(0, 4),
//                             spreadRadius: 0,
//                               ),
//                               BoxShadow(
//                             color: Color(0x3F000000),
//                             blurRadius: 4,
//                             offset: Offset(4, 0),
//                             spreadRadius: 0,
//                               ),
//                               BoxShadow(
//                             color: Color(0x3F000000),
//                             blurRadius: 4,
//                             offset: Offset(4, 0),
//                             spreadRadius: 0,
//                               )
//                             ],
//                         ),
//                     ),
//                 ),
//             ],
//         ),
//     ),
// );
//   }
// }