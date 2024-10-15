import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "../style/colors.dart";



class NormalAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String Title;
  final height;
  final   actionbutton;
  final onTap;

  
   const NormalAppbar(
    {super.key,
    required this.Title,
    required this.onTap,
    this.actionbutton, required this.height});

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
        actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: actionbutton,
            )
        ],


    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}