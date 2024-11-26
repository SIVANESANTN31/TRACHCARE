import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/Apiurl.dart';
import 'package:http/http.dart' as http;
import 'package:trachcare/Screens/Views/Admin/Adminscreens/Doctorlist.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/editdoctordetails.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/patientlist%20copy.dart';
import 'package:trachcare/components/custom_button.dart';
import 'dart:convert';
import '../../../../components/NAppbar.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';
import '../Adminmainpage.dart';


class Doctordetails extends StatefulWidget {
  final String Doctor_id;

  const Doctordetails({
    super.key,
    required this.Doctor_id,
  });

  @override
  _DoctordetailsState createState() => _DoctordetailsState();
}

class _DoctordetailsState extends State<Doctordetails> {
  final TextEditingController usernameController =
      TextEditingController(text: "");
  final TextEditingController doctorRegNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails(); // Fetch data when the widget is initialized
  }

  
  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    await fetchDoctorDetails();
    setState(() {});
  }


Future<dynamic> deleteDoctorDetails() async {
  final String url = '$doctordetailsUrl?doctor_id=${widget.Doctor_id}';

  print('API URL: $url'); // Debugging purpose

  try {
    final response = await http.delete(Uri.parse(url));
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

             deleteDoctorDetails();
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

  Future<dynamic> fetchDoctorDetails() async {
    final String url = '$doctordetailsUrl?doctor_id=${widget.Doctor_id}';

    print('API URL: $url'); // Debugging purpose

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data["doctorInfo"];
      } else {
        print('Failed to fetch doctor details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: NormalAppbar(Title: "Doctors Details",height: dn.height(10), onTap: (){
      //  Navigator.of(context,rootNavigator: true).pop();

                 Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => Doctorlist()),(route)=>false);
                               },
                               ),
      body: FutureBuilder(
          future: fetchDoctorDetails(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                usernameController.text = data["username"];
                doctorRegNoController.text = data['doctor_reg_no'];
                emailController.text = data['email'];
                phoneNumberController.text = data['phone_number'];
                passwordController.text = data['password'];
                var imagepath = data["image_path"].toString().substring(2);
                print(data["image_path"]);
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                   // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              //backgroundColor: Colors.grey[300],
                              backgroundImage: NetworkImage("https://$ip/Trachcare/$imagepath"),
                              //child: const Icon(Icons.person, size: 50, color: Colors.blue),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: GoogleFonts.ibmPlexSans(
                            textStyle: TextStyle(
                                color: BlackColor, fontSize: 13.sp)),
                        controller: usernameController,
                        enabled: false,
                        decoration: InputDecoration(
                          focusColor: BlackColor,
                          labelText: 'username',
                          labelStyle: TextStyle(color: BlackColor),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: BlackColor)),
                                  
                          filled: true,
                          //fillColor: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: doctorRegNoController,
                        enabled: false,
                        style: GoogleFonts.ibmPlexSans(
                            textStyle: TextStyle(
                                color: BlackColor, fontSize: 13.sp)),
                        decoration: InputDecoration(
                          labelText: 'Doctor_reg_no',
                          labelStyle: TextStyle(color: BlackColor),
                          border: const OutlineInputBorder(),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        enabled: false,
                        style: GoogleFonts.ibmPlexSans(
                            textStyle: TextStyle(
                                color: BlackColor, fontSize: 13.sp)),
                        decoration: InputDecoration(
                          labelText: 'Email Id',
                          labelStyle: TextStyle(color: BlackColor),
                          border: const OutlineInputBorder(),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneNumberController,
                        enabled: false,
                        style: GoogleFonts.ibmPlexSans(
                            textStyle: TextStyle(
                                color: BlackColor, fontSize: 13.sp)),
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: BlackColor),
                          border: const OutlineInputBorder(),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        enabled: false,
                        obscureText: true,
                        style: GoogleFonts.ibmPlexSans(
                            textStyle: TextStyle(
                                color: BlackColor, fontSize: 13.sp)),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: BlackColor),
                          border: const OutlineInputBorder(),
                          filled: true,
                          //fillColor: Colors.orange[100],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              custom_Button(
                              text: "Edit",
                              width: 45,
                              height: 8,
                              backgroundColor: Colors.green,
                              textcolor: whiteColor,
                              button_funcation: () {
                          var data = snapshot.data;
                          String doctorId = widget.Doctor_id; 
                          String imagepath = data["image_path"].toString().substring(2); 
                          String doctorRegNo = data['doctor_reg_no'].toString();
                          String username = data['username'].toString();
                          String email = data['email'].toString();
                          String phoneNumber = data['phone_number'].toString();
                          String password = data['password'].toString();
                          print(imagepath);
                          // Pass the fetched data to AdminEditProfile
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Editdoctordetails(
                                doctorId: doctorId,
                                imagepath: imagepath,
                                doctorRegNo: doctorRegNo,
                                username: username,
                                email: email,
                                phoneNumber: phoneNumber,
                                password: password,
                              ),
                            ),
                          );
                        },
                              textSize: 11),
                               custom_Button(
                              text: "patients",
                              width: 48,
                              height: 8,
                              backgroundColor: Colors.blue,
                              textcolor: whiteColor,
                              button_funcation: (){
                                Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => patientlist(doctor_id: widget.Doctor_id),),);
                              },
                              textSize: 10),
                            ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: custom_Button(
                                text: "Delete",
                                width: 48,
                                height: 8,
                                backgroundColor: Colors.red,
                                textcolor: whiteColor,
                                button_funcation: (){
                                 btn_fun();
                                },
                                textSize: 11),
                      ),
                          const SizedBox(height: 24),
                    ],
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(
                  radius: 10,
                ),
              );
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
          const Text("Something went wrong!!"),
        ],
      ),
    );
          }),
    );
  }
}
