// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trachcare/style/colors.dart';

class subhead extends StatelessWidget {
  final String Subhead;
  const subhead({super.key, required this.Subhead});

  @override
  Widget build(BuildContext context) {
    return Text(Subhead,style:  GoogleFonts.ibmPlexSans(
                        textStyle: const TextStyle(
                            fontSize: 22,
                            color: Color(0XFF455A64),
                            fontWeight: FontWeight.bold)),);
  }
}