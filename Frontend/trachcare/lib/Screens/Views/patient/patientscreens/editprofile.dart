import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../Api/API_funcation/doctordetails.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../Api/DataStore/Datastore.dart';
import '../../../../style/colors.dart';
import '../../../../components/custom_button.dart';
import '../../../../style/utils/Dimention.dart';
import 'patientprofile.dart';

class Editpatientprofile extends StatefulWidget {
    final String patient_id;
  

  Editpatientprofile({super.key, required this.patient_id,});

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

  var imagefile, base64encode, fileimage;

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails(); // Fetch data when the widget is initialized
  }

 Future<dynamic> fetchDoctorDetails() async {
  print(Doctor_id);
   var Data ={
    "patient_id":patient_id.toString()
  };
  try {
    final response = await http.post(Uri.parse(getpatientdetialsurl),body: jsonEncode(Data));
    if(response.statusCode ==200){
      var data = jsonDecode(response.body);
      if(data['Status']){
        return data['pateintinfo'];
      }
      else{
        return data['pateintinfo'];
      }
    }
  } catch (e) {
    print(e);
    
  }
}
  void _save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      updatePatientDetails(
        context,
        widget.patient_id ,
        imagefile,
        usernameController.text,
        emailController.text,
        phoneNumberController.text,
        passwordController.text,
      );

      _formKey.currentState!.reset();
      setState(() {
        usernameController.clear();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: dn.height(25),
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
                     child: FutureBuilder(
        future: fetchDoctorDetails(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              usernameController.text = data["username"].toString();
              doctorRegNoController.text = data['doctor_reg_no'].toString();
              emailController.text = data['email'].toString();
              phoneNumberController.text = data['phone_number'];
              passwordController.text = data['password'];
              var imagepath = data["image_path"].toString().substring(2);
              print(data["image_path"]);
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 26, left: 16, right: 16),
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
                              fillColor: whiteColor,
                              labelText: 'Username',
                              border: const OutlineInputBorder(),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Doctor Registration Number Field
                          // TextFormField(
                          //   controller: doctorRegNoController,
                          //   textInputAction: TextInputAction.next,
                          //   decoration: InputDecoration(
                          //     labelText: 'Doctor_reg_no',
                          //     border: const OutlineInputBorder(),
                          //     filled: true,
                          //   ),
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter Doctor Registration Number';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // const SizedBox(height: 16),
                          // Email Field
                          TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              fillColor: whiteColor,
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
                              fillColor: whiteColor,
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
                              fillColor: whiteColor,
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
                                   

        ),
        
                                        ),
                                        
                                        ],
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
                                _save(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => p_ProfilePage(),
                                ));
                              },
                              textSize: 12,
                            ),
                          ),),
                                                   SizedBox(height: 10.h),
                                        ],
                                        ),
      ),);
                     }
              }
