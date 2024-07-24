import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/AudioScreen.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/PatientDashborad.dart';
import 'package:trachcare/style/colors.dart';

import 'Bottomnavigator/Addpatients.dart';
import 'Bottomnavigator/Doctorsdashboard.dart';
import 'Bottomnavigator/patientslist.dart';

class Doctormainpage extends StatefulWidget {
  const Doctormainpage({super.key});

  @override
  _DoctormainpageState createState() => _DoctormainpageState();
}

class _DoctormainpageState extends State<Doctormainpage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<Widget> pages = [
    DoctorDashBoard(),
    Addpatients(),
    patientslist(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: pages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: pages,
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _tabController,
        builder: (context, child) {
          return CupertinoTabBar(
            activeColor: BlackColor,
            inactiveColor: grey_color,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: "Home",
                activeIcon: Icon(CupertinoIcons.house_fill),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_add_alt_1),
                label: "Add Patients",
                activeIcon: Icon(Icons.person_add_alt_1_sharp),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                label: "Patients List",
                activeIcon: Icon(Icons.person_sharp),
              ),
            ],
            onTap: (index) {
              _tabController.index = index; // Update current index
            },
          );
        },
      ),
    );
  }
}
