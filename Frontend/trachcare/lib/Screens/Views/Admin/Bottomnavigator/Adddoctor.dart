// import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Api/API_funcation/doctordetails.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../components/Appbar_copy.dart';
import '../../../../style/utils/Dimention.dart';

class Adddoctor extends StatefulWidget {
  Adddoctor({super.key});

  @override
  State<Adddoctor> createState() => _AdddoctorState();
}

class _AdddoctorState extends State<Adddoctor> {
  LoginDataStore store = LoginDataStore();

  String username = "";
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController doctorRegNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var imagefile;

  void _save(BuildContext context) {
    if (_formKey.currentState!.validate() && imagefile != null) {
      // Handle form submission
      addDoctorDetails(
        context,
        imagefile,
        usernameController.text,
        doctorRegNoController.text,
        emailController.text,
        phoneNumberController.text,
        passwordController.text,
      );

      _formKey.currentState!.reset();
      setState(() {
        usernameController.clear();
        doctorRegNoController.clear();
        emailController.clear();
        phoneNumberController.clear();
        passwordController.clear();
        imagefile = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a photo and fill in all required fields.")),
      );
    }
  }

  void getimage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (file != null) {
      setState(() {
        imagefile = File(file.path);
        print(imagefile);
      });
    }
  }

  void photo_picker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              getimage(source: ImageSource.camera);
            }),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            isDefaultAction: true,
            onPressed: () {
              getimage(source: ImageSource.gallery);
              Navigator.of(context, rootNavigator: true).pop();
            }),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: Duplicate_Appbar(Title: "Add Doctor", height: dn.height(10)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 70, left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                Center(
                  child: Column(
                    children: [
                      if (imagefile == null)
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/images/doctor.png"),
                        )
                      else
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(imagefile),
                        ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          photo_picker(context);
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
                // Username Field
                TextFormField(
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                  inputFormatters: [
    LengthLimitingTextInputFormatter(40),
  ],
                  validator: (value) {

  // // Regular expression to check if the email contains any number
   String numberPattern = r'[0-9]';

  if (value == null || value.isEmpty) {
    return 'Please enter a username';
  }
  if (RegExp(numberPattern).hasMatch(value)) {
    return 'Email should not contain any numbers';
  }

  return null;
},
                  onChanged: (value) {
                  setState(() {
                   _formKey.currentState?.validate();
                  });
                },
                ),
                const SizedBox(height: 16),

                // Doctor Registration Number Field
                TextFormField(
                  controller: doctorRegNoController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Doctor Reg No',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                 validator: (value) {
  // // Regular expression to check if the email contains any special character except '@'
  String specialCharacterPattern = r'[!#$%&*+/=?^_`{|}~]';
  if (value == null || value.isEmpty) {
    return 'Please enter a Register no';
  }
  if (value.length < 5) {
    return 'Email should be at least 5 characters long';
  }
  if (RegExp(specialCharacterPattern).hasMatch(value)) {
    return 'Email should not contain any special characters';
  }
  return null;
},
                  onChanged: (value) {
                  setState(() {
                   _formKey.currentState?.validate();
                  });
                },
                ),
                const SizedBox(height: 16),

                // Email Field
               

TextFormField(
  controller: emailController,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    labelText: 'Email Id',
    border: const OutlineInputBorder(),
    filled: true,
    fillColor: Colors.orange[100],
  ),
  // Limit the text input to 50 characters
  inputFormatters: [
    LengthLimitingTextInputFormatter(50),
  ],
  validator: (value) {
  // // Regular expression to check if the email contains any special character except '@'
  String specialCharacterPattern = r'[!#$%&*+/=?^_`{|}~]';

  // // Regular expression to check if the email contains any number
   String numberPattern = r'[0-9]';

  if (value == null || value.isEmpty) {
    return 'Please enter a valid email address';
  }
  
  if (!value.contains('@')) {
    return 'Email must contain "@"';
  }

  if (value.length < 10) {
    return 'Email should be at least 5 characters long';
  }

  if (RegExp(specialCharacterPattern).hasMatch(value)) {
    return 'Email should not contain any special characters other than "@"';
  }

  if (RegExp(numberPattern).hasMatch(value)) {
    return 'Email should not contain any numbers';
  }

  return null;
},
  onChanged: (value) {
    setState(() {
      _formKey.currentState?.validate();
    });
  },
),

                const SizedBox(height: 16),

                // Phone Number Field
                TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                  setState(() {
                   _formKey.currentState?.validate();
                  });
                },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () => _save(context),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                  inputFormatters: [
    LengthLimitingTextInputFormatter(20),
  ],
  validator: (value) {


  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }

  if (value.length < 8) {
    return 'Email should be at least 8 characters long';
  }


  return null;
},
                  onChanged: (value) {
                  setState(() {
                   _formKey.currentState?.validate();
                  });
                },
                ),
                const SizedBox(height: 24),

                // Save Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _save(context),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
