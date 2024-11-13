import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../style/colors.dart';
import '../style/utils/Dimention.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TitleColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.chevron_left,
            color: BlackColor,
            size: 3.h, // Adjust icon size for responsiveness
          ),
        ),
        title: Text(
          "About us",
          style: GoogleFonts.ibmPlexSans(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 10, 26, 7),
              fontSize: 18.sp, // Adjusted font size for larger screens
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA7DBAF), Color(0xFFFFD9A0)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: dn.height(5)),
                const Text(
                  'TRACHCARE',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20, // Increased font size for iPad readability
                  ),
                ),
                SizedBox(height: dn.height(2)),
                Image.asset(
                  'assets/images/0.png',
                  width: 60.w, // Adjusted image width for larger screen
                ),
                SizedBox(height: dn.height(5)),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Definitions Tracheostomy, a surgical procedure involving the creation of an airway through the neck, is often necessitated by various medical conditions, including respiratory failure, trauma, or prolonged intubation. Following tracheostomy, patients require meticulous care to manage their airways effectively, prevent complications, and optimize their quality of life. However, providing adequate care at home can be challenging for patients and caregivers due to the complexity of tracheostomy management and the need for continuous monitoring and intervention.'
                    '\n\nMobile Health Applications in Tracheostomy Care'
                    '\nIn response to these challenges, the development of mobile health applications has emerged as a promising solution to support patients and caregivers in managing tracheostomy care at home. TrachCare is one such mobile application designed to optimize tracheostomy care by providing a comprehensive range of features.'
                    '\n\nFeatures of TrachCare'
                    '\nTrachCare includes informative videos to educate patients on essential tasks such as:'
                    '\n\n- Cleaning the inner tube'
                    '\n- Changing tracheostomy ties'
                    '\n- Performing daily cleaning and dressing around the tube site'
                    '\n- Proper suctioning technique, etc.'
                    '\n\nEmpowering Patients and Caregivers'
                    '\nBy leveraging the capabilities of mobile technology, TrachCare aims to empower patients and caregivers with the knowledge, tools, and support needed to navigate the complexities of tracheostomy care effectively.'
                    '\n\nResearch and Evaluation'
                    '\nThis abstract outlines the rationale behind the development of this application and its potential to improve the quality of life for post-operative tracheostomy patients. Through a comprehensive evaluation of effectiveness and user experience of this app, this research aims to assess the impact of mobile application optimization on home tracheostomy care and patient outcomes. By exploring the usability, acceptability, and clinical benefits of TrachCare, this study seeks to contribute to the growing body of evidence supporting the integration of mobile health technology in tracheostomy care management.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16, // Adjusted font size for readability
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
