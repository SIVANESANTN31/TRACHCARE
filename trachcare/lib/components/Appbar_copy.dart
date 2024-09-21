import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "../style/colors.dart";



class Duplicate_Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String Title;
  final double height;
   const Duplicate_Appbar({super.key, required this.Title, required this.height});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      backgroundColor: TitleColor,
      title: Text(Title,style: GoogleFonts.ibmPlexSans(
                textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: BlackColor_light,
                fontSize: 15.sp)),),
                centerTitle: true,
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(90);
}