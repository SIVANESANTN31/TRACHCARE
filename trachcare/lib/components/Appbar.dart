import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/components/Navbardrawer.dart';
import 'package:trachcare/style/colors.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String Name;
  final PreferredSizeWidget ? bottom;

   Appbar({super.key, required this.Name,this.
   bottom});

  @override
  AppBar build(BuildContext context) {
    return AppBar(backgroundColor: TitleColor,
    shape:  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    )),
     leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );}),
     
    centerTitle: true,
    title: Text("Hi,${Name}",style:GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          
                          fontWeight: FontWeight.bold)),),
      actions: [
        IconButton(onPressed: (){} ,icon: Icon(CupertinoIcons.chat_bubble_2,size: 29,color: Colors.green,))
      ],
     bottom: bottom,
     automaticallyImplyLeading: false,
      );
      
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(190);
}

