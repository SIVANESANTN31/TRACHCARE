// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:trachcare/Screens/started/WelcomePage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
  with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Navigate to the next screen after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Welcome_page()),
      );
    });
    }
  

@override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
     overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA7DBAF), Color(0xFFFFD9A0)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/0.png'),
            const Text(
              'Trachcare',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ],)
      ),
    );
  }
}
