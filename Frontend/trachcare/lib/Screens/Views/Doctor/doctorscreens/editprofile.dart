import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/doctorprofile.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../style/colors.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/utils/Dimention.dart';

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentregno;
  final String currentphno;

  EditProfilePage({super.key, required this.currentName, required this.currentEmail,required this.currentregno, required this.currentphno});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController doctorRegNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var _profileImage = currentimage;
  
  static get currentimage => null;

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.currentName;
    emailController.text = widget.currentEmail;
    doctorRegNoController.text = widget.currentregno;
    phoneNumberController.text = widget.currentphno;
    
  }

  
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
         _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> updateDoctorDetails() async {
    var updatedData = {
      "doctor_id": Doctor_id.toString(),
      "username": usernameController.text,
      "email": emailController.text,
      "phone_number": phoneNumberController.text,
      "password": passwordController.text,
      'image': _profileImage,
    };

    try {
      final response = await http.post(Uri.parse(UpdateDoctorDetailsUrl), 
          body: jsonEncode(updatedData),
          headers: {
            'Content-Type': 'application/json',
          });
      
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['Status']) {
          // Profile updated successfully
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to update profile.'),
            backgroundColor: Colors.red,
          ));
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error occurred while updating profile.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
 Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    color: TitleColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: SafeArea(
                    child: InkWell(
                          onTap:(){
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(CupertinoIcons.chevron_left,color: BlackColor,size: 28.0,),
                        ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 110,
                    left: 30,
                    right: 30,
                    bottom: 0,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: loginFormcolor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                     child: Center(
                       child: SingleChildScrollView(
                                 child: Center(
                                   child: Padding(
                                     padding: const EdgeInsets.all(16.0),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Center(
                                           child: Column(
                                             children: [
                                                           GestureDetector(
                                                     onTap: _pickImage,
                                                     child: CircleAvatar(
                                                       radius: 50,
                                                       backgroundColor: Colors.grey[300],
                                                       backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                                                       child: _profileImage == null ? Icon(Icons.camera_alt, size: 50, color: Colors.grey) : null,
                                                     ),
                                                   ),
                                   
                                                           SizedBox(height: 20),
                                             ],
                                           ),
                                         ),
                                                               SizedBox(height: 20),
                                        TextFormField(
                                         style: GoogleFonts.ibmPlexSans(
                                                             textStyle: TextStyle(
                                                               color: BlackColor,
                                                                 fontSize: 13.sp))
                                                                 ,
                                           controller: usernameController,
                                           enabled: true,
                                           decoration: InputDecoration(
                                             focusColor: BlackColor,
                                             labelText: 'username',
                                             labelStyle: TextStyle(color: BlackColor),
                                             border: const OutlineInputBorder
                                             (
                                                           borderSide: BorderSide(color: BlackColor)
                                             ),
                                             
                                             filled: true,
                                             fillColor: const Color.fromARGB(255, 255, 255, 255),
                                           ),
                                         ),
                                         SizedBox(height: 16),
                                         TextFormField(
                                           controller: doctorRegNoController,
                                           enabled: true,
                                           style: GoogleFonts.ibmPlexSans(
                                                             textStyle: TextStyle(
                                                               color: BlackColor,
                                                                 fontSize: 13.sp)),
                                           decoration: InputDecoration(
                                             labelText: 'Doctor_reg_no',
                                             labelStyle: TextStyle(color: BlackColor),
                                             border: const OutlineInputBorder(),
                                             filled: true,
                                             fillColor: const Color.fromARGB(255, 255, 255, 255),
                                           ),
                                         ),
                                       SizedBox(height: 16),
                                         TextFormField(
                                           controller: emailController,
                                           enabled: true,
                                           style: GoogleFonts.ibmPlexSans(
                                                             textStyle: TextStyle(
                                                               color: BlackColor,
                                                                 fontSize: 13.sp))
                                                                 ,
                                           decoration: InputDecoration(
                                             labelText: 'Email Id',
                                             labelStyle: TextStyle(color: BlackColor),
                                             border: const OutlineInputBorder(),
                                             filled: true,
                                             fillColor: const Color.fromARGB(255, 255, 255, 255),
                                           ),
                                         ),
                                         SizedBox(height: 16),
                                         TextFormField(
                                           controller: phoneNumberController,
                                           enabled: true,
                                           style: GoogleFonts.ibmPlexSans(
                                                             textStyle: TextStyle(
                                                               color: BlackColor,
                                                                 fontSize: 13.sp))
                                                                 ,
                                           decoration: InputDecoration(
                                             labelText: 'Phone Number',
                                             labelStyle: TextStyle(color: BlackColor),
                                             border: const OutlineInputBorder(),
                                             filled: true,
                                             fillColor: const Color.fromARGB(255, 255, 255, 255),
                                           ),
                                         ),
                
                                    SizedBox(height: 24),
                                     
                                   
                                             ],
                                           ),
                                         ),
                                 ),
    ),
                                   ),
                                   

        ),
        
                                        ),
                                        
                                        ],
                                        ),
                                        SizedBox(height: 40),
                                               Center(
                                                 child: custom_Button(
                                                     text: "Save profile",
                                                     width: 60,
                                                     height: 6,
                                                     button_funcation: (){
                                                       Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(builder: (context) => ProfilePage()
                                                                                             ),
                                                                                          );
                                                     },
                                                     backgroundColor: sucess_color,
                                                     textcolor: whiteColor,
                                                     textSize: 13),
                                               ),
                                                   SizedBox(height: 10.h),
                                        ],
                                        ),
      ),);
                     }
              }
