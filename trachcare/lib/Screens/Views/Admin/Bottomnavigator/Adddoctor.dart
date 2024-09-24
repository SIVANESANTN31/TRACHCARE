import 'dart:convert';
import 'dart:io';

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

  String username ="";
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController doctorRegNoController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void _save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
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
      
      // Clear the form fields after submission
      usernameController.clear();
      doctorRegNoController.clear();
      emailController.clear();
      phoneNumberController.clear();
      passwordController.clear();

      // Optionally, reset the form state
      _formKey.currentState!.reset();
    }
  }
var imagefile,base64encode,fileimage;
void getimage({required ImageSource source}) async {
    final file =
        await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (file != null) {
      
      final imageBytes = await file.readAsBytes();
      var base64encoder = base64Encode(imageBytes);
      setState(() {
         base64encode = base64encoder; 
         
      });
    }

    if (file?.path != null) {
      setState(() {
         imagefile = File(file!.path);
         fileimage = file!.path;
         print(fileimage);
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
                child: const Text("cancel"),
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
      appBar: Duplicate_Appbar(Title: "Add doctor", height: dn.height(10)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16,bottom: 70,left: 16,right: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                Center(
                  child: Column(
                    children: [
                      if(imagefile==null)
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:   AssetImage("assets/images/doctor.png"),
                        // backgroundColor: Colors.grey[300],
                        // child: const Icon(Icons.person, size: 50, color: Colors.blue),
                      )
                      else 
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(imagefile),
                        // backgroundColor: Colors.grey[300],
                        // child: const Icon(Icons.person, size: 50, color: Colors.blue),
                      ),

                       SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: ()  {
                       //Iamgepic.photo_picker(context);
                       photo_picker(context);
                        },
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Change Picture'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Username Field
                TextFormField(
                  validator: (value) {
                      String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                final regex = RegExp(pattern);
              if (value == null || value.isEmpty) {
                return 'Please Enter username';
              }
                return null;
            },
            onSaved: (value) {
                  username  = value!; 
                  store.Setusername(username);
                  
                },
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                  // validator: (username) {
                  //   if (username!.isEmpty) {
                  //     return 'Please enter a username';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 16),

                // Doctor Registration Number Field
                TextFormField(
                  controller: doctorRegNoController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Doctor_reg_no',
                    
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Doctor Registration Number';
                    }
                    return null;
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
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
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
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onEditingComplete:()=>_save(context) ,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Buttons: Edit and Delete
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _save(context),
                      child: const Text('Save'),
                    ),const SizedBox(height: 15,),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.red,
                    //   ),
                    //   onPressed: () {
                    //     // Handle delete logic here
                    //     print('Details Deleted');
                    //   },
                    //   child: Text('Delete'),
                    // ),
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