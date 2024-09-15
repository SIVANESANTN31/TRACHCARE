import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/doctordetails.dart';

import '../../../../Api/API_funcation/doctordetails.dart';
import '../../../../style/utils/Dimention.dart';

class Adddoctor extends StatelessWidget {
  Adddoctor({super.key});

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


  @override
  Widget build(BuildContext context) {
    Dimentions dn = new Dimentions(context);
     return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('Doctor Profile'),
        backgroundColor: const Color.fromRGBO(78, 230, 126, 1),
      ),
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
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, size: 50, color: Colors.blue),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle picture change
                        },
                        icon: Icon(Icons.camera_alt),
                        label: Text('Change Picture'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Username Field
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                  validator: (username) {
                    if (username!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Doctor Registration Number Field
                TextFormField(
                  controller: doctorRegNoController,
                  decoration: InputDecoration(
                    labelText: 'Doctor_reg_no',
                    border: OutlineInputBorder(),
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
                SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Id',
                    border: OutlineInputBorder(),
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
                SizedBox(height: 16),

                // Phone Number Field
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
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
                SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
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
                SizedBox(height: 24),

                // Buttons: Edit and Delete
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _save(context),
                      child: Text('Save'),
                    ),SizedBox(height: 15,),
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