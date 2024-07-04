import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "../style/colors.dart";



class Duplicate_Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String Title;
  final  IconButton actionbutton;
   Duplicate_Appbar({super.key, required this.Title,   required this.actionbutton});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      backgroundColor: TitleColor,
    shape:  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(20),

    )),
    title: Text(Title,style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: BlackColor_light,
                            fontSize: 15.sp)),),

        centerTitle: true,
        // actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: actionbutton,
        //     )
        // ],


    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(90);
}