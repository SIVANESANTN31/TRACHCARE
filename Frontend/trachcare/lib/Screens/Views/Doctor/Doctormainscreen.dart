import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/videolist.dart';
import 'package:trachcare/style/colors.dart';
import 'Bottomnavigator/Doctorsdashboard.dart';
import 'Bottomnavigator/patientslist.dart';

class Doctormainpage extends StatelessWidget {
  const Doctormainpage({super.key});

  @override
  Widget build(BuildContext context) {
    List pages=[
      DoctorDashBoard(),
      Videolist(),
      patientslist(),
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
                  icon: Icon(Icons.video_collection_outlined),
                  label: "video list",
                  activeIcon: Icon(Icons.video_collection),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined),
                  label: "Patients List",
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