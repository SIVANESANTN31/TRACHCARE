import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:trachcare/Screens/Views/Admin/Adminscreens/Doctorlist.dart';
import '../../../../Api/API_funcation/doctordetails.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../components/NAppbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';

class Editdoctordetails extends StatefulWidget {
  final String doctorId;
  final String imagepath;
  final String username;
  final String doctorRegNo;
  final String email;
  final String phoneNumber;
  final String password;
  

  Editdoctordetails({
    super.key,
    required this.doctorId,
    required this.imagepath,
    required this.username,
    required this.doctorRegNo,
    required this.email,
    required this.phoneNumber,
    required this.password,
    });

  @override
  State<Editdoctordetails> createState() => _EditdoctordetailsState();
}

class _EditdoctordetailsState extends State<Editdoctordetails> {
  LoginDataStore store = LoginDataStore();
  String username = "";
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController doctorRegNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  File? imageFile;
  var imagepath;

  @override
  void initState() {
    super.initState();
    // Set the initial values from the final values passed to the widget
    setInitialValues();
  }

  void setInitialValues() {
    imagepath= widget.imagepath;
    usernameController.text = widget.username; // Adjust if username is available in widget data
    doctorRegNoController.text = widget.doctorRegNo;
    emailController.text = widget.email;
    phoneNumberController.text = widget.phoneNumber;
    passwordController.text = widget.password;
    
  }

  void _save(BuildContext context, dynamic finalImage) {
    if (_formKey.currentState!.validate()) {
      updateDoctorDetails(
        context,
        widget.doctorId,
        finalImage,
        usernameController.text,
        doctorRegNoController.text,
        emailController.text,
        phoneNumberController.text,
        passwordController.text,
      );

      // Reset form and clear inputs
      _formKey.currentState!.reset();
      setState(() {
        usernameController.clear();
        doctorRegNoController.clear();
        emailController.clear();
        phoneNumberController.clear();
        passwordController.clear();
        imageFile = null;
      });
    }
  }
  
  Future<dynamic> fetchDoctorDetails() async {
    final String url = '$doctordetailsUrl?doctor_id=${widget.doctorId}';
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

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }

  void photoPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              getImage(source: ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            isDefaultAction: true,
            onPressed: () {
              getImage(source: ImageSource.gallery);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar:  NormalAppbar(Title: "Edit Doctors Details",height: dn.height(10), onTap: (){
          Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Doctorlist(),
                ),);},),
      body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 26, left: 16, right: 16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage: imageFile != null
                                            ? FileImage(imageFile!)
                                            : NetworkImage("https://$ip/Trachcare/$imagepath")
                                                as ImageProvider,
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          photoPicker(context);
                                        },
                                        icon: const Icon(Icons.camera_alt),
                                        label: const Text('Change Picture'),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: Colors.grey[200],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter username';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    username = value!;
                                    store.Setusername(username);
                                  },
                                  controller: usernameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    border: const OutlineInputBorder(),
                                    filled: true,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: doctorRegNoController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Doctor Registration Number',
                                    border: const OutlineInputBorder(),
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Doctor Registration Number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Email ID',
                                    border: const OutlineInputBorder(),
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty || !value.contains('@')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: phoneNumberController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    border: const OutlineInputBorder(),
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a phone number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: const OutlineInputBorder(),
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                ),
                                Center(
  child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: custom_Button(
      text: "Save",
      width: 48,
      height: 8,
      backgroundColor: const Color.fromARGB(255, 58, 182, 41),
      textcolor: whiteColor,
      button_funcation: () {
        var image_path = null;
        dynamic finalImage = imageFile ?? image_path;
        _save(context, finalImage);
        
        // Show success dialog before navigation
        showSuccessDialog(context);
      },
      textSize: 12,
    ),
  ),
),


                                SizedBox(height: dn.height(5)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
    );
  }

  
 void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Success"),
        content: const Text("Profile saved successfully!"),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop(); // Close the dialog
              // Navigate to profile page after dialog is closed
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Doctorlist(),
                ),
              );
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
}
