import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/style/colors.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String Name;
  final PreferredSizeWidget ? bottom;

   Appbar({super.key, required this.Name,this.
   bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: TitleColor,
    shape:  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    )),
    // leading: Icon(Icons.menu),
    
    centerTitle: true,
    title: Text("Hi,${Name}",style:GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          
                          fontWeight: FontWeight.bold)),),
      actions: [
        IconButton(onPressed: (){} ,icon: Icon(CupertinoIcons.chat_bubble_2,size: 29,color: Colors.green,))
      ],
     bottom: bottom
      );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(180);
}