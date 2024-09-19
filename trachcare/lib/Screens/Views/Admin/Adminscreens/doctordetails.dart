import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trachcare/Api/Apiurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../style/colors.dart';

class Doctordetails extends StatefulWidget {
  
  final String Doctor_id;
  
  const Doctordetails({super.key, required this.Doctor_id,});

  @override
  _DoctordetailsState createState() => _DoctordetailsState();
}

class _DoctordetailsState extends State<Doctordetails> {
  final TextEditingController usernameController = TextEditingController(text: "");
  final TextEditingController doctorRegNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails(); // Fetch data when the widget is initialized
  }

  Future<dynamic> fetchDoctorDetails() async {
  final String url = '$ViewdoctordetailsUrl?doctor_id=${widget.Doctor_id}';

  print('API URL: $url');  // Debugging purpose

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      
      var data = json.decode(response.body);
      return data;


      }
    
    else {
      print('Failed to fetch doctor details');
    }
  } catch (e) {
    print('Error: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Doctor Profile (View Only)'),
        backgroundColor: const Color.fromARGB(255, 140, 207, 88),
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
                  return 
         SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, size: 50, color: Colors.blue),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
               TextFormField(
                  controller: usernameController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'username',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: doctorRegNoController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Doctor_reg_no',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Email Id',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneNumberController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.orange[100],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
                 );}
              }
      else if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CupertinoActivityIndicator(radius: 10,),);
      }
      return Center(child: Text("Something went Wrong !!!"),);
  }),
    );
  }
}
