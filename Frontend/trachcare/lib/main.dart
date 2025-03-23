import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_kit/media_kit.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';
import 'package:trachcare/Screens/AuthScreens/SplashScreen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {

 HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();

  runApp(ToastificationWrapper(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override


  
  Widget build(BuildContext context) {

    return Sizer( 
  builder: (context, orientation, screenType) {
      return MaterialApp( 
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.ibmPlexSansTextTheme()),
        
        home: const SplashScreen()
      );
  });
    
    }
} 