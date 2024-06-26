import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/AuthScreens/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp( 
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.ibmPlexSansTextTheme()),
        
        home: const SplashScreen()
      );
  });
    
    }
}

