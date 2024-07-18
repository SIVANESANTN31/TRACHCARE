import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/AudioScreen.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/Medication.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/PatientDashborad.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/videospage.dart';
import 'package:trachcare/style/colors.dart';

class PatientMainScreen extends StatelessWidget {
  const PatientMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List pages=[
       PatientDashBoard(),
       AudioScreen(),
       Videospage(),
       MedicationPage(),
       
    ];



    return CupertinoTabScaffold(

          tabBar: CupertinoTabBar(
            backgroundColor: Colors.grey[50],
            activeColor:BlackColor ,
             inactiveColor: grey_color,


            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Home",
                  activeIcon: Icon(CupertinoIcons.house_fill)

              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.multitrack_audio_outlined),
                  label: "Audio",
                  activeIcon: Icon(Icons.multitrack_audio_sharp)
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_collection_outlined),
                  label: "Video",
                  activeIcon: Icon(Icons.video_collection)
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.medication_liquid_sharp),
                  label: "Medications",
                  activeIcon: Icon(Icons.medication_liquid_rounded)
              )
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