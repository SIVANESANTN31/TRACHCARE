import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:trachcare/style/colors.dart';
import '../../../../Api/API_funcation/DashboardApi.dart';
import '../../../../style/utils/Dimention.dart';
import '../patientscreens/calender.dart';
import '../patientscreens/dailyupdates.dart';
class MedicationPage extends StatelessWidget {
  const MedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToDailyUpdates(String name, String imagePath) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YourdailyReports (
            name: name,
            imagePath: imagePath,
          ),
        ),
      );
    }

    void navigateToDailyReports(String name, String imagePath) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => calender(
            name: name,
            imagePath: imagePath,
          ),
        ),
      );
    }

    Dimentions dn = Dimentions(context);

    return FutureBuilder(
      future: PatientDashBoardApi().FetchDetials(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator(radius: 10));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var patientDetails = snapshot.data['Dashboard'];
            var name = patientDetails['username'].toString();
            var imagePath = patientDetails["image_path"].toString().substring(2);
            print(imagePath);

            return Scaffold(
              appBar: NormalAppbar(
                Title: "Diagnostics",
                height: dn.height(10),
                onTap: null,
              ),
              body: Column(
                children: [
                  // Image container
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 45.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/D1.png")),
                      ),
                    ),
                  ),
                  // Reports containers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Daily Updates
                      GestureDetector(
                        onTap: () => navigateToDailyUpdates(name, imagePath),
                        child: Container(
                          width: 42.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: loginFormcolor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.history, size: 50, color: whiteColor),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Update your Daily Reports",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ibmPlexSans(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Daily Reports
                      GestureDetector(
                        onTap: () => navigateToDailyReports(name, imagePath),
                        child: Container(
                          width: 42.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: loginFormcolor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.calendar_today_rounded, size: 50, color: whiteColor),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Records of your Daily Reports",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ibmPlexSans(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Center(child: Text("No data available."));
          }
        }

        return const Center(child: Text("Error fetching data."));
      },
    );
  }
}
