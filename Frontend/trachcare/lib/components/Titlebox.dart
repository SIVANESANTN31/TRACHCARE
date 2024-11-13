import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trachcare/style/colors.dart';

import '../style/utils/Dimention.dart';

class Titlehead extends StatelessWidget {
  final String titleName;
   const Titlehead({super.key, required this.titleName});

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Container(
                  width: dn.width(40),
                  height: dn.height(7),
                  decoration: BoxDecoration(
                      color: TitleColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
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
                        textStyle: const TextStyle(
                            fontSize: 22,
                            color: whiteColor,
                            fontWeight: FontWeight.bold)),
                  )));
  }
}