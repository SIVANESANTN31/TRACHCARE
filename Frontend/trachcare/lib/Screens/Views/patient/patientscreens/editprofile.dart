import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Screens/Views/patient/patientscreens/patientprofile.dart';
import '../../../../Api/API_funcation/doctordetails.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../style/colors.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/utils/Dimention.dart';

class Editpatientprofile extends StatefulWidget {
  final String patientId;
  final String imagepath;
  final String username;
  final String doctorRegNo;
  final String email;
  final String phoneNumber;
  final String password;

  Editpatientprofile({
    super.key,
    required this.patientId,
    required this.imagepath,
    required this.username,
    required this.doctorRegNo,
    required this.email,
    required this.phoneNumber,
    required this.password, 
  });

  @override
  State<Editpatientprofile> createState() => _EditpatientprofileState();
}

class _EditpatientprofileState extends State<Editpatientprofile> {
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
               Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => p_ProfilePage(),));
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

  void _save(BuildContext context, dynamic finalImage) {
    if (_formKey.currentState!.validate()) {
      updatePatientDetails(
        context,
        widget.patientId,
        finalImage,
        usernameController.text,
        emailController.text,
        phoneNumberController.text,
        passwordController.text,
      );

      // Reset form and clear inputs
      _formKey.currentState!.reset();
      setState(() {
        usernameController.clear();
        
        emailController.clear();
        phoneNumberController.clear();
        passwordController.clear();
        imageFile = null;
      });
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
                          onTap: () {
                            Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => p_ProfilePage()),
                  );
                    //         Navigator.of(context,rootNavigator: true).pop();
                  
                    //  Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => p_ProfilePage()),(route)=>false);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              CupertinoIcons.chevron_left,
                              color: BlackColor,
                              size: 28.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 100,
                        left: 30,
                        right: 30,
                        bottom: 0,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: loginFormcolor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
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
                      ),
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
