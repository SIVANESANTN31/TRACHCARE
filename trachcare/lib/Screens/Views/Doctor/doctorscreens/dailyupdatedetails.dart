import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../style/colors.dart';

class selectedDay extends StatelessWidget {
  late final String selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Vitals Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Date: ${selectedDate ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(height: 16),
                  Namecard("Siva", "132"),
            SizedBox(height: 16),
            Text('Vitals', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildInfoRow('Respiratory Rate', '18'),
            _buildInfoRow('Heart Rate', '100'),
            _buildInfoRow('SPO2 @ Room Air', '100'),
            _buildYesNoRow('Daily dressing done?', true),
            _buildYesNoRow('Tracheostomy tie changed?', true),
            _buildYesNoRow('Suctioning done?', true),
            _buildYesNoRow('has the patient started on oral feeds?', true),
            _buildYesNoRow('has the patient been changed to green tube?', true),
            _buildInfoRow('Spigotting status', 'Not Applicable'),
            _buildYesNoRow('Is the patient able to breathe through nose, while\nblocking the tube with hands?', true),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _buildInfoRow('If Yes, How long the patient can able to breath?', '1 min'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildYesNoRow(String question, bool value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(question)),
          Text(value ? 'Yes' : 'No', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}



Widget Namecard(String name, String patientId) {
  return Container(
    margin: const EdgeInsets.all(10),
    width: double.infinity,
    height: 12.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: BlackColor, width: 0.3)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CircleAvatar(
          minRadius: 20,
          child: Image(image: AssetImage("assets/images/doctor.png")),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Name",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    ),
                    Text(
                      "Patient Id ",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      ":",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    ),
                    Text(
                      ": ",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    ),
                    Text(
                      patientId,
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: TextStyle(fontSize: 13.sp)),
                    )
                  ],
                )
              ],
            ))
      ],
    ),
  );
}