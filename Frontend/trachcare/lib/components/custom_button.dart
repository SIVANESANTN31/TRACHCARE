import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../style/utils/Dimention.dart';

class custom_Button extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color backgroundColor;
  final double textSize;
  final button_funcation;
  final IconData? icon;
  final Color textcolor;
  final List<BoxShadow>? boxShadow;
  
  const custom_Button( 
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      required this.backgroundColor,
      this.boxShadow,
      this.button_funcation,
      this.icon,
      required this.textcolor, required this.textSize,});

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadow ?? [ 
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),

        ],
      ),
      alignment: Alignment.center,
      width: dn.width(width),
      height: dn.height(height),
      child: CupertinoButton(
        onPressed: button_funcation,
        color: backgroundColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style:  GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                            fontSize: textSize.sp,
                            color: textcolor,
                            fontWeight: FontWeight.bold)),
              ),
              icon == null
                  ? const Text("")
                  : Icon(
                      icon,
                      size: 28,
                      color: textcolor,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
