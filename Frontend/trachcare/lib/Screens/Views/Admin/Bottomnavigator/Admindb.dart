// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/Addvideos.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/patientslist.dart';
import "package:trachcare/components/Appbar.dart";
import '../../../../Api/API_funcation/DashboardApi.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/Navbardrawer.dart';
import '../Adminscreens/Doctorlist.dart';
import '../Adminscreens/Profileviewpage.dart';
import "package:http/http.dart" as http;
class Admindb extends StatefulWidget {
  Admindb({super.key});

  @override
  State<Admindb> createState() => _AdmindbState();
}

class _AdmindbState extends State<Admindb> {
  List imgList = [
    'doctorlist',
    'video',
    'patientlist',
    // 'download',
  ];

  List pages_name = [
    'Doctors list',
    'Add videos',
    'Patients list',
    // 'Export Patients Data'
  ];

  get image => ["assets/images/Vector-1.png"];

  @override
  Widget build(BuildContext context) {
    List pages = [
      const Doctorlist(),
      VideoUploadPage(),
      patients_list(),
      
    ];

    bool _isDownloading = false;

// Function to download the CSV file from the PHP backend
Future<void> downloadCSV(BuildContext context) async {
  setState(() {
    _isDownloading = true;
  });

  // Replace with your PHP backend URL that serves the CSV
  final String url = "$exporturl";

  try {
    // Make the HTTP request to get the CSV file
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Allow the user to pick a directory
      String? directoryPath = await FilePicker.platform.getDirectoryPath();

      if (directoryPath == null) {
        // User canceled the picker
        print('No directory selected.');
        toastification.show(
          alignment: Alignment.bottomRight,
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('No Directory Selected'),
          icon: const Icon(Icons.cancel_rounded, color: Colors.red),
          showIcon: true,
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 2),
        );
        return;
      }

      // Generate a unique file name
      String fileName = 'patient_details_${DateTime.now().millisecondsSinceEpoch}.csv';
      String filePath = '$directoryPath/$fileName';
      File file = File(filePath);

      // Ensure a unique filename
      int counter = 1;
      while (await file.exists()) {
        fileName = 'patient_details_${DateTime.now().millisecondsSinceEpoch}_$counter.csv';
        filePath = '$directoryPath/$fileName';
        file = File(filePath);
        counter++;
      }

      // Write the content to the file
      await file.writeAsBytes(response.bodyBytes);
      print('CSV saved at: $filePath');

      // Notify the user
      toastification.show(
        alignment: Alignment.bottomRight,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        context: context,
        title: Text('Saved Successfully'),
        icon: const Icon(Icons.check_circle, color: Colors.green),
        showIcon: true,
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 2),
      );

      // // Open the file
      // OpenFile.open(filePath);
    } else {
      // Handle error if the request fails
      toastification.show(
        alignment: Alignment.bottomRight,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        context: context,
        title: Text('Error Downloading CSV'),
        icon: const Icon(Icons.cancel_rounded, color: Colors.red),
        showIcon: true,
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 2),
      );
    }
  } catch (e) {
    print('Error occurred: $e');
    toastification.show(
      alignment: Alignment.bottomRight,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      context: context,
      title: Text('An error occurred'),
      icon: const Icon(Icons.error_outline, color: Colors.red),
      showIcon: true,
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
    );
  } finally {
    setState(() {
      _isDownloading = false;
    });
  }
}

  // Show confirmation dialog before starting the download
  void _showDownloadDialog(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Download CSV'),
        content: Text('Do you want to download the all patients details?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              downloadCSV(context); // Start downloading
            },
            child: Text('Download'),
          ),
        ],
      );
    },
  );
}
    

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth >= 768;

    return FutureBuilder(
      future: AdminDashBoardApi().FetchDetials(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 10,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            var regno = data['doctor_reg_no'].toString();
            var name = data['username'].toString();
            var imagepath = data["image_path"].toString().substring(2);

            return Scaffold(
              appBar: Appbar(
                Name: name,
                height: screenHeight * 0.12,
                notification: false,
                export: true,
                onExportPressed: (){_showDownloadDialog(context);},
              ),
              drawer: drawer(
                Name: name,
                reg_no: regno,
                imagepath: NetworkImage("https://$ip/Trachcare/$imagepath"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => a_ProfilePage(),
                    ),
                  );
                },
              ),
              body: Stack(
                children: [
                  // Background image with blur effect
                  

ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/5.png'), 
                
              ),
            ),
          ),
        ),
        

                  // Scrollable content
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: isTablet ? 100 : 100),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 20.0 : 10.0),
                          child: GridView.builder(
                            itemCount: imgList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isTablet ? 3 : 2,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => pages[index],
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0XFFFFD9A0),
                                        Color(0XFFFFEDD2)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          "assets/images/${imgList[index]}.png",
                                          width: screenWidth * 0.2,
                                          height: screenHeight * 0.1,
                                        ),
                                      ),
                                      Text(
                                        pages_name[index],
                                        style: TextStyle(
                                          fontSize: isTablet ? 14 : 12,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black.withOpacity(1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }
        return Center(child: Text("Something went wrong!!"));
      },
    );
  }
}
