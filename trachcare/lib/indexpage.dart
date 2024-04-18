// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:trachcare/admin/adminlogin.dart';
import 'package:trachcare/doctor/doctorlogin.dart';
import 'package:trachcare/patient/patientlogin.dart';




class indexpage extends StatelessWidget {
  const indexpage({super.key});

//   const Login({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Hello(),
//     );
//   }
// }
//
// class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              bottom: 500, // Adjust this value to move the image up or down
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/logo.jpeg', // Assuming you have an image named logo.png in your assets folder
                fit: BoxFit.contain, // Adjust the BoxFit as per your requirement
                width: MediaQuery.of(context).size.width * 0.7, // Adjust the size of the image
                height: MediaQuery.of(context).size.width * 0.6, // Adjust the size of the image
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  width: 400,
                  height: 470,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF66D0D0), Colors.white], // Replace with your gradient colors
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      SizedBox(
                        width: 270, // Adjust the width of the box
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:  (context) =>  const PatientLogin()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Patient',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 100), // Adjust the spacing between text and image
                              Image.asset(
                                'assets/docicon.png', // Replace with your image path
                                width: 30, // Adjust the width of the image
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: 270, // Adjust the width of the box
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:  (context) =>  const DoctorLogin()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Doctor',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 100), // Adjust the spacing between text and image
                              Image.asset(
                                'assets/paticon.png', // Replace with your image path
                                width: 30, // Adjust the width of the image
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Are you admin ?',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AdminLogin()),
                              );
                            },
                            child: const Text(
                              'Admin',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.blue,
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
          ],
        ),
      ),
    );
  }
}