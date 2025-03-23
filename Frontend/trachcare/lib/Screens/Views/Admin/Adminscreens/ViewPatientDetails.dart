// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/calender.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/patientslist.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import '../Adminmainpage.dart';

class ViewPatientDetails extends StatefulWidget {
  final String patientId;

  const ViewPatientDetails({super.key, required this.patientId});
  @override
  _ViewPatientDetailsState createState() => _ViewPatientDetailsState();
}

class _ViewPatientDetailsState extends State<ViewPatientDetails> {
  Map<String, dynamic> patientDetails = {}; // To store fetched data
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchPatientDetails(); // Fetch data when the screen loads
  }

  Future<dynamic> deletePatientDetails() async {
  final String url = '$UpdatePatientDetailsUrl?patient_id=${widget.patientId}';

  print('API URL: $url'); // Debugging purpose

  try {
    final response = await http.delete(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data["message"]; // Assuming the API returns a message on successful deletion
      
    } else {
      print('Failed to delete doctor details: ${response.statusCode}');
      return null; // Return null or an appropriate message
    }
  } catch (e) {
    print('Error: $e');
    return null; // Handle the error as needed
  }
}
Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    }
    return false;
  }

  // Function to get the Downloads directory
  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }
  
  // Show confirmation dialog before starting the download
  void _showDownloadDialog(BuildContext context,Map<String, dynamic> patientDetails) {

    print(patientDetails);
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Download PDF'),
          content: Text('Do you want to download the PDF file?'),
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
                downloadPDF(context); // Start downloading
              },
              child: Text('Download'),
            ),
          ],
        );
      },
    );
  }
bool _isDownloading = false;

// Function to download the PDF file from the PHP backend
Future<void> downloadPDF(BuildContext context) async {
  setState(() {
    _isDownloading = true;
  });

  // Replace with your PHP backend URL that serves the PDF
  final String url = "$ViewPatientDetailsUrl?patient_id=${widget.patientId}"; // Example URL

  try {
    // Make the HTTP request to get the PDF file
    final response = await http.get(Uri.parse(url));
    print(response.body);
    print("==================================================================================");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data['patient_id']);
      print("==================================================================================");

      setState(() {
        patientDetails = {
          'doctor_id': data['doctor_id'],
          'patient_id': data['patient_id'],
          'name': data['username'],
          'age': data['age'] ?? 'NIL',
          'address': data['address'] ?? 'NIL',
          'bmi': data['bmi'] ?? 'NIL',
          'gender': data['gender'] ?? 'NIL',
          'diagnosis': data['diagnosis'] ?? 'NIL',
          'appoinment': data['appoinment'] ?? 'NIL',
          'surgeryStatus': data['surgery_status'] ?? 'NIL',
          'postOpTracheostomyDay': data['post_op_tracheostomy_day'] ?? 'NIL',
          'tubeNameSize': data['tube_name_size'] ?? 'NIL',
          'baselineVitals': data['baseline_vitals'] ?? 'NIL',
          'respiratoryRate': data['respiratory_rate'] ?? 'NIL',
          'heartRate': data['heart_rate'] ?? 'NIL',
          'spo2RoomAir': data['spo2_room_air'] ?? 'NIL',
          'indicationOfTracheostomy': data['indication_of_tracheostomy'] ?? 'NIL',
          'comorbidities': data['comorbidities'] ?? 'NIL',
          'hemoglobin': data['hemoglobin'] ?? 'NIL',
          'srSodium': data['sr_sodium'] ?? 'NIL',
          'srPotassium': data['sr_potassium'] ?? 'NIL',
          'srCalcium': data['sr_calcium'] ?? 'NIL',
          'srBicarbonate': data['sr_bicarbonate'] ?? 'NIL',
          'pt': data['pt'] ?? 'NIL',
          'aptt': data['aptt'] ?? 'NIL',
          'inr': data['inr'] ?? 'NIL',
          'platelets': data['platelets'] ?? 'NIL',
          'liverFunctionTest': data['liver_function_test'] ?? 'NIL',
          'renalFunctionTest': data['renal_function_test'] ?? 'NIL',
          'image': data['image_path'].toString(),
        };
      });

      print(patientDetails);
      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&**************************");

      // // Request storage permission if needed
      // if (!await requestPermissions()) {
      //   print('Permissions not granted.');
      //   return;
      // }
      final pdf = pw.Document();

// Add content to the PDF
pdf.addPage(
  pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Title
          pw.Text(
            'Patient Details Report',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 20),

          // Details Table
          if (patientDetails.isNotEmpty)
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black, width: 1),
              columnWidths: {
                0: pw.FlexColumnWidth(2), // Details Column
                1: pw.FlexColumnWidth(3), // Values Column
              },
              children: [
                // Table Header
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                     pw.Padding(
                      padding: const pw.EdgeInsets.all(6.0),
                      child:
                     pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'Details',
                                  style: pw.TextStyle(fontSize: 14,
                          fontWeight: pw.FontWeight.bold,),
                                ),
                               
                              ],
                            ),),
                             pw.Padding(
                      padding: const pw.EdgeInsets.all(6.0),
                      child:
                       pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'Values',
                                  style: pw.TextStyle(fontSize: 14,
                          fontWeight: pw.FontWeight.bold,),
                                ),
                               
                              ],
                            ),),
                  ],
                ),
                // Table Rows for Details and Values
                for (var i = 0; i < patientDetails.length; i += 1)
                  pw.TableRow(
                    children: [
                       pw.Padding(
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(
                                  patientDetails.entries.elementAt(i).key,
                                  style: pw.TextStyle(fontSize: 12),
                                ),
                               
                              ],
                            ),),
                             pw.Padding(
                      padding: const pw.EdgeInsets.all(2.0),
                      child:
                       pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(
                                  patientDetails.entries.elementAt(i).value,
                                  style: pw.TextStyle(fontSize: 12),
                                ),
                               
                              ],
                            ),),
                    ],
                  ),
              ],
            )
          else
            pw.Text(
              'No patient details available.',
              style: pw.TextStyle(fontSize: 16, color: PdfColors.red),
            ),

          pw.SizedBox(height: 20),

          // Footer
          pw.Text(
            'Generated on: ${DateTime.now().toString()}',
            style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
          ),
        ],
      );
    },
  ),
);


      // // Save or share the PDF file as needed
      
        String? directoryPath = await FilePicker.platform.getDirectoryPath();
        String fileName = 'patient_details_${patientDetails['patient_id']}.pdf';
        String filePath = '$directoryPath/$fileName';
        File file = File(filePath);
    // final directoryPath = await getExternalStorageDirectory();
    // String fileName = 'patient_details_${patientDetails['patient_id']}.pdf';
    // String filePath = '${directoryPath!.path}/patient_details_${patientDetails['patient_id']}.pdf';
    // File file = File(filePath);
     // Ensure a unique filename
  int counter = 1;
  while (await file.exists()) {
    fileName = 'patient_details_${patientDetails['patient_id']}_$counter.pdf';
    filePath = '$directoryPath/$fileName';
    file = File(filePath);
    counter++;
  }

    await file.writeAsBytes(await pdf.save());
    print('PDF saved at: $filePath');
 

      // // Write the content to the file
      // await file.writeAsBytes(response.bodyBytes);
      // print('CSV saved at: $filePath');

      // pdf.save() or use share functionality
      toastification.show(
        alignment: Alignment.bottomRight,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        context: context, // optional if you use ToastificationWrapper
        title: Text('Saved successfully'),
        icon: const Icon(Icons.check_circle_outline, color: Colors.green),
        showIcon: true, // show or hide the icon
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 2),
      );
    // Open the PDF file
    OpenFile.open(filePath);
    } else {
      // Handle error if the request fails
      toastification.show(
        alignment: Alignment.bottomRight,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        context: context, // optional if you use ToastificationWrapper
        title: Text('Error'),
        icon: const Icon(Icons.cancel_rounded, color: Colors.red),
        showIcon: true, // show or hide the icon
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 2),
      );
    }
  } catch (e) {
    print('Error fetching data: $e');
    toastification.show(
      alignment: Alignment.bottomRight,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      context: context, // optional if you use ToastificationWrapper
      title: Text('Error'),
      icon: const Icon(Icons.cancel_rounded, color: Colors.red),
      showIcon: true, // show or hide the icon
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
    );
  } finally {
    setState(() {
      _isDownloading = false;
    });
  }
}


  
void alertdilog(){
      showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete'),
        content: const Text('Are sure you want to delete this user?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context,"no");
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {

             deletePatientDetails();
                  Navigator.of(context,rootNavigator: true).pop();

                 Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => Adminmainpage()),(route)=>false); 
            },
            child: const Text('Yes'),
          ),
        
      ]),
    );

    }

  void btn_fun() {
   alertdilog();
  }

  // Function to fetch patient details from the server
  Future<void> fetchPatientDetails() async {
    final String url = '$ViewPatientDetailsUrl?patient_id=${widget.patientId}';
    
    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data['patient_id']);
        setState(() {
          patientDetails = {
            'doctor_id': data['doctor_id'],
            'patient_id': data['patient_id'],
            'name': data['username'],
            'age': data['age'] ?? 'NIL',
            'address': data['address'] ?? 'NIL',
            'bmi': data['bmi'] ?? 'NIL',
            'gender': data['gender'] ?? 'NIL',
            'diagnosis': data['diagnosis'] ?? 'NIL',
            'appoinment': data['appoinment'] ?? 'NIL',
            'surgeryStatus': data['surgery_status'] ?? 'NIL',
            'postOpTracheostomyDay': data['post_op_tracheostomy_day'] ?? 'NIL',
            'tubeNameSize': data['tube_name_size'] ?? 'NIL',
            'baselineVitals': data['baseline_vitals'] ?? 'NIL',
            'respiratoryRate': data['respiratory_rate'] ?? 'NIL',
            'heartRate': data['heart_rate'] ?? 'NIL',
            'spo2RoomAir': data['spo2_room_air'] ?? 'NIL',
            'indicationOfTracheostomy': data['indication_of_tracheostomy'] ?? 'NIL',
            'comorbidities': data['comorbidities'] ?? 'NIL',
            'hemoglobin': data['hemoglobin'] ?? 'NIL',
            'srSodium': data['sr_sodium'] ?? 'NIL',
            'srPotassium': data['sr_potassium'] ?? 'NIL',
            'srCalcium': data['sr_calcium'] ?? 'NIL',
            'srBicarbonate': data['sr_bicarbonate'] ?? 'NIL',
            'pt': data['pt'] ?? 'NIL',
            'aptt': data['aptt'] ?? 'NIL',
            'inr': data['inr'] ?? 'NIL',
            'platelets': data['platelets'] ?? 'NIL',
            'liverFunctionTest': data['liver_function_test'] ?? 'NIL',
            'renalFunctionTest': data['renal_function_test'] ?? 'NIL',
            'image': data['image_path'].toString(),
          };
        });
      } else {
        print('Failed to load patient details');
      }
    } catch (e) {
      print('Error fetching patient details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(
        Title: "Patient Details",
        height: dn.height(10),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => patients_list(),
          ));
        },
        export: true,
        onExportPressed: (){_showDownloadDialog(context,patientDetails);},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: patientDetails.isNotEmpty
              ? Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                          Center(
  child: ClipOval(
    child: Image.network(
      "https://$ip/Trachcare/${patientDetails['image'].toString().substring(2)}",  // Ensure full URL
      height: dn.height(20),
      width: dn.height(20),
      fit: BoxFit.cover,
      // errorBuilder: (context, error, stackTrace) {
      //   return Icon(Icons.person, size: 100); // Placeholder if image fails to load
      // },
    ),
  ),
),
                      SizedBox(height: 20),
                      buildFormField('Name', patientDetails['name']),
                      buildFormField('Age', patientDetails['age']),
                      buildFormField('BMI', patientDetails['bmi']),
                      buildFormField('Gender', patientDetails['gender']),
                      buildFormField('Address', patientDetails['address']),
                      buildFormField('Next Appoinment', patientDetails['appoinment']),
                      buildFormField('Diagnosis', patientDetails['diagnosis']),
                      buildFormField('Surgery Status', patientDetails['surgeryStatus']),
                      buildFormField('Post-Op Tracheostomy Day', patientDetails['postOpTracheostomyDay']),
                      buildFormField('Tube Name and Size', patientDetails['tubeNameSize']),
                      buildFormField('Baseline Vitals', patientDetails['baselineVitals']),
                      buildFormField('Respiratory Rate', patientDetails['respiratoryRate']),
                      buildFormField('Heart Rate', patientDetails['heartRate']),
                      buildFormField('SPO2 @ Room Air', patientDetails['spo2RoomAir']),
                      buildFormField('Indication of Tracheostomy', patientDetails['indicationOfTracheostomy']),
                      buildFormField('Comorbidities', patientDetails['comorbidities']),
                      buildFormField('Hemoglobin', patientDetails['hemoglobin']),
                      buildFormField('Sr. Sodium', patientDetails['srSodium']),
                      buildFormField('Sr. Potassium', patientDetails['srPotassium']),
                      buildFormField('Sr. Calcium', patientDetails['srCalcium']),
                      buildFormField('Sr. Bicarbonate', patientDetails['srBicarbonate']),
                      buildFormField('PT', patientDetails['pt']),
                      buildFormField('APTT', patientDetails['aptt']),
                      buildFormField('INR', patientDetails['inr']),
                      buildFormField('Platelets', patientDetails['platelets']),
                      buildFormField('Liver Function Test', patientDetails['liverFunctionTest']),
                      buildFormField('Renal Function Test', patientDetails['renalFunctionTest']),
                     
                    //  Center(
                    //     child: ElevatedButton(
                    //                       onPressed: () => CalendarScreen(
                    //                       key: UniqueKey(),
                    //                       patientId: patientDetails['patient_id'],
                    //                       name: patientDetails['name'], // Assuming 'username' is a field in your data
                    //                       imagePath: patientDetails['image']
                    //                           .toString()
                    //                           .substring(2), // Assuming 'image_path' is a field in your data
                    //                     ),
                    //                       child: const Text('Daily Queries reports'),
                    //                     ),
                    //   ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: custom_Button(
                                text: "Daily Queries reports",
                                width: dn.width(25),
                                height: dn.height(1),
                                backgroundColor: const Color.fromARGB(255, 244, 174, 54),
                                textcolor: whiteColor,
                                button_funcation: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => a_CalendarScreen(
                                        key: UniqueKey(),
                                        patientId: patientDetails['patient_id'],
                                        name: patientDetails['name'], // Assuming 'username' is a field in your data
                                        imagePath: patientDetails['image'].toString().substring(2)// Assuming 'image_path' is a field in your data
                                      ),),);
                                },
                                textSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: custom_Button(
                                  text: "Delete",
                                  width: dn.width(15),
                                  height: dn.height(1),
                                  backgroundColor: Colors.red,
                                  textcolor: whiteColor,
                                  button_funcation: (){
                                   btn_fun();
                                  },
                                  textSize: 12),
                        ),
                      ),
                      
                       SizedBox(height: dn.height(10)),

                          
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()), // Show a loading spinner while fetching data
        ),
      ),
    );
  }

  // Function to build a form field for each patient detail
  Widget buildFormField(String label, String? initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        initialValue: initialValue ?? 'Not available',
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        readOnly: true, // Set to false if you want to allow editing
      ),
    );
  }
}
 