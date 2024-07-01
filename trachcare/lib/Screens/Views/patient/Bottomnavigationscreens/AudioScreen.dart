import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/components/NAppbar.dart";
import "package:trachcare/components/custom_button.dart";
import "package:trachcare/style/colors.dart";

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    List words = [
      "YES",
      "NO",
      "WATER",
      "HELP",
      "YES",
      "NO",
      "WATER",
      "HELP",
      "YES",
      "NO",
      "WATER",
      "HELP"
    ];
    List colour = [
      Color(0XFF82FF87),
      Color(0XFFFB8A72),
      Color(0XFFA8ECE8),
      Color(0XFFEEECFF),
      Color(0XFF82FF87),
      Color(0XFFFB8A72),
      Color(0XFFA8ECE8),
      Color(0XFFEEECFF),
      Color(0XFF82FF87),
      Color(0XFFFB8A72),
      Color(0XFFA8ECE8),
      Color(0XFFEEECFF)
    ];

    return Scaffold(
      appBar: NormalAppbar(
        Title: "Tap To Speak",
        actionbutton: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.translate,
              color: whiteColor,
              size: 28,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 6),
              child: Container(
                // alignment: Alignment.center,
                width: 95.w,
                height: 62.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: BlackColor),
                    color: whiteColor),
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Helpercontainer(words[index], colour[index]));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Container(
                // alignment: Alignment.center,
                width: 95.w,
                height: 9.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: TitleColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 60.w, height: 6.h, child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type word to speak",
                        filled: true,
                        fillColor: whiteColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))
                      ),
                    )),
                    Container(
                      width: 20.w,
                      height: 6.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: loginFormcolor),
                      child: Text("Speak",
                      //textAlign: TextAlign.center,
                      style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                            fontSize: 13.sp)),),
                    )
                   
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Helpercontainer(String text, Color colour) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        width: 18.w,
        height: 8.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colour,
            boxShadow: [
              BoxShadow(
                color: BlackColor_light,
                blurRadius: 4.0,
              ),
            ]),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.ibmPlexSans(
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
        ),
      ),
    );
  }
}
