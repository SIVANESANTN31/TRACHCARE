import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:trachcare/style/colors.dart';
import '../../../../Api/API_funcation/DashboardApi.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../components/Appbar_copy.dart';
import '../../../../style/utils/Dimention.dart';
import '../patientscreens/calender.dart';
import '../patientscreens/dailyupdates.dart';
import "package:http/http.dart" as http;
class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {

    
     List<dynamic> reports = [];
     bool isLoading = true;
   

  @override
  void initState() {
    super.initState();
    fetchReports();
  }
   
void alertdilog(){
      showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Multiple Reports'),
        content: const Text('You have already updated your daily Queries.'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context,"no");
            },
            child: const Text('OK'),
          ),
          
        
      ]),
    );

    }

  void btn_fun() {
   alertdilog();
  }
  
Future<List<dynamic>> fetchDailyReport(String doctorId) async {
  final String apiUrl = dailyreport; // Update this URL

  // Construct the full URL with query parameters
  final Uri uri = Uri.parse('$apiUrl?patient_id=$patient_id');

  try {
    // Send the GET request
    final response = await http.get(uri);

    // Check the response status
    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> reports = json.decode(response.body);
      print(reports);
      return reports; // Return the list of reports
    } else {
      throw Exception('Failed to load reports: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    return []; // Return an empty list on error
  }
}
  Future<void> fetchReports() async {
    reports = await fetchDailyReport(patient_id);
    setState(() {
      isLoading = false;
    });
  }
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
              appBar:Duplicate_Appbar(Title: "Diagnostics", height: dn.height(10)),
               
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
                       onTap: () {
    if (reports.length > 0) {
      btn_fun();
    } else {
      navigateToDailyUpdates(name, imagePath);
    }
  },
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
                                  "Update your Daily Queries",
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
            return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/error.gif', // Change this path if necessary
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20),
          const Text("Sorry server error!!"),
        ],
      ),
    );
          }
        }

        return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/error.gif', // Change this path if necessary
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20),
          const Text("Error fetching data."),
        ],
      ),
    );
      },
    );
  }
}
