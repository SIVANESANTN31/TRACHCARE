import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trachcare/style/colors.dart';

class Titlehead extends StatelessWidget {
  final String titleName;
   Titlehead({super.key, required this.titleName});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: TitleColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: BlackColor_light,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(0, 3.54),
                        )
                      ]),
                  child: Center(
                      child: Text(
                    titleName,
                    style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: 22,
                            color: whiteColor,
                            fontWeight: FontWeight.bold)),
                  )));
  }
}