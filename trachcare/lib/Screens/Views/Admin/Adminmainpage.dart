// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/style/colors.dart';
import 'Bottomnavigator/Adddoctor.dart';
import 'Bottomnavigator/Admindb.dart';
import 'Bottomnavigator/assigndoctor.dart';


class Adminmainpage extends StatelessWidget {
  const Adminmainpage({super.key});

  @override
  Widget build(BuildContext context) {
    List pages=[
       Admindb(),
       Adddoctor(),
       assigndoctor(),
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
                  icon: Icon(CupertinoIcons.calendar_circle),
                  label: "Add Doctor",
                  activeIcon: Icon(CupertinoIcons.calendar_circle_fill)
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined),
                  label: "Assign Doctors",
                  activeIcon: Icon(Icons.person_sharp)
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