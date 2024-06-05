import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:trachcare/style/colors.dart";

class Welcome_page extends StatefulWidget {
  const Welcome_page({super.key});

  @override
  State<Welcome_page> createState() => _Welcome_pageState();
}

class _Welcome_pageState extends State<Welcome_page> {
  @override
  Widget build(BuildContext context) {
    var Screen_Size = MediaQuery.of(context).size; 
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/images/welcome.jpeg"),fit: BoxFit.cover),
          ),
          child: SafeArea(
            top: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("TRACHCARE", style: GoogleFonts.ibmPlexSans(textStyle: TextStyle(fontSize: 22,color: whiteColor)),),
                Container(
                  width: Screen_Size.width/0.25,
                )
                  
            ],),
          ),
          
          
          ),
    );
  }
}
