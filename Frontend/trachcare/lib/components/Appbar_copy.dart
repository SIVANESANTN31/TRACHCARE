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
    shape:  const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(20),

    )),
    title: Text(Title,style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 10, 26, 7),
                            fontSize: 15.sp)),),
        centerTitle: true,
        


    );
  }
  
  @override
  
  Size get preferredSize => const Size.fromHeight(70);
}