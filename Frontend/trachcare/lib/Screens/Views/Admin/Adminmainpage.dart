// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/Admin/Bottomnavigator/videolist.dart';
import 'package:trachcare/style/colors.dart';
import 'Bottomnavigator/Adddoctor.dart';
import 'Bottomnavigator/Admindb.dart';



class Adminmainpage extends StatelessWidget {
  const Adminmainpage({super.key});

  @override
  Widget build(BuildContext context) {
    List pages=[
       Admindb(),
       Adddoctor(),
        Videolist(),
    ];
    return CupertinoTabScaffold(

          tabBar: CupertinoTabBar(
            // backgroundColor: widget_color,
            activeColor:BlackColor ,
             inactiveColor: grey_color,

            
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Home",
                  activeIcon: Icon(CupertinoIcons.house_fill),
                  

              ),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_add),
                  label: "Add Doctor",
                  activeIcon: Icon(CupertinoIcons.person_add_solid)
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_collection_outlined),
                  label: "Video List",
                  activeIcon: Icon(Icons.video_collection)
              ),
              
              
            ],
          ),
          tabBuilder:
              (BuildContext context, int index) {
            return
              CupertinoTabView(builder: (BuildContext context) {
                return pages[index];
              });
        });
  }
}