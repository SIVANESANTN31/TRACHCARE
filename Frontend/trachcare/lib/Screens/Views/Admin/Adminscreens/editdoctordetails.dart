import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:trachcare/Screens/Views/Admin/Adminscreens/doctordetails.dart';
import '../../../../Api/API_funcation/doctordetails.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../components/Appbar_copy.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';

class Editdoctordetails extends StatefulWidget {
  final String Doctor_id;

  Editdoctordetails({super.key, required this.Doctor_id});

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

  var imagefile, base64encode, fileimage;

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails(); // Fetch data when the widget is initialized
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

  void _save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      updateDoctorDetails(
        context,
        widget.Doctor_id ,
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
    }
  }

  
  void getimage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (file != null) {
      final imageBytes = await file.readAsBytes();
      var base64encoder = base64Encode(imageBytes);
      setState(() {
        base64encode = base64encoder;
      });
      setState(() {
        imagefile = File(file.path);
        fileimage = file.path;
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
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            isDefaultAction: true,
            onPressed: () {
              getimage(source: ImageSource.gallery);
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
      appBar: Duplicate_Appbar(Title: "Edit Doctor Details", height: dn.height(10)),
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
                child: SingleChildScrollView(
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
                                    backgroundImage: NetworkImage("https://$ip/Trachcare/$imagepath"),
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
                            validator: (value) {
                              // String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              // final regex = RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return 'Please Enter username';
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
                          // Doctor Registration Number Field
                          TextFormField(
                            controller: doctorRegNoController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Doctor_reg_no',
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
                          // Email Field
                          TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Email Id',
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
                          // Phone Number Field
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
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: custom_Button(
                              text: "Delete",
                              width: 48,
                              height: 8,
                              backgroundColor: Colors.red,
                              textcolor: whiteColor,
                              button_funcation: () {
                                _save(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Doctordetails(Doctor_id: widget.Doctor_id),
                                ));
                              },
                              textSize: 11,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
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
            child: Text("Something went Wrong !!!"),
          );
        },
      ),
    );
  }
}
