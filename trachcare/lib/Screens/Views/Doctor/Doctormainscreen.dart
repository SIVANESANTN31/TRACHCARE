import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/AudioScreen.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/PatientDashborad.dart';
import 'package:trachcare/style/colors.dart';

import 'Bottomnavigator/Addpatients.dart';
import 'Bottomnavigator/Doctorsdashboard.dart';
import 'Bottomnavigator/patientslist.dart';

class Doctormainpage extends StatelessWidget {
  const Doctormainpage({super.key});

  @override
  Widget build(BuildContext context) {
    List pages=[
       DoctorDashBoard(),
       Addpatients(),
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
                  activeIcon: Icon(CupertinoIcons.house_fill)

              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_add_alt_1),
                  label: "Add Patients",
                  activeIcon: Icon(Icons.person_add_alt_1_sharp)
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined),
                  label: "Patients List",
                  activeIcon: Icon(Icons.person_sharp)
              ),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.medication_liquid_sharp),
              //     label: "Medications",
              //     activeIcon: Icon(Icons.medication_liquid_rounded)
              // )
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