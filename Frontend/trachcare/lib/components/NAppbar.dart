// ignore_for_file: must_be_immutable

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "../style/colors.dart";



class NormalAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String Title;
  final height;
  final actionbutton;
  final onTap;
  bool?export=false;
  final VoidCallback? onExportPressed; 

  
    NormalAppbar(
    {super.key,
    required this.Title,
    required this.onTap,
    this.actionbutton, 
    required this.height,
    this.export,
    this.onExportPressed});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      backgroundColor: TitleColor,
    shape:  const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(20),

    )),

    leading: Builder(builder: (BuildContext context) {
      return IconButton(
        icon: Icon(
                      CupertinoIcons.chevron_left,
                      color: BlackColor,
                      size: 28.0,
                    ),
        onPressed: onTap,
        // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }),
      centerTitle: true,
    title: Text(Title,style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 10, 26, 7),
                            fontSize: 15.sp)),),
      
        actions: [
  Padding(
    padding: const EdgeInsets.only(top: 10,right: 5),
    child: Stack(
      children: [
        if (export ?? false ) // Only render IconButton if `export` is true
          IconButton(
            onPressed: () {
              if (onExportPressed != null) {
                onExportPressed!(); // Trigger the export function
              }
            },
            icon: Icon(
              Icons.sim_card_download_outlined,
              color: Colors.green,
              size: 28,
            ),
          ),

        
      ],
    ),
  ),
],

    );
  }
  
  @override
  
  Size get preferredSize => Size.fromHeight(height);
}