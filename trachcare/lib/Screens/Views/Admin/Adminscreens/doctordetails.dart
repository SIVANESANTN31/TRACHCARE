import 'package:flutter/material.dart';

class Doctordetails extends StatelessWidget {
  Doctordetails({super.key});
  final TextEditingController usernameController = TextEditingController(text: "Mahalakshmi E Recycler Pvt.Ltd");
  final TextEditingController doctorRegNoController = TextEditingController(text: "0123456789");
  final TextEditingController emailController = TextEditingController(text: "recycler@gmail.com");
  final TextEditingController phoneNumberController = TextEditingController(text: "+14987888999");
  final TextEditingController passwordController = TextEditingController(text: "recycler@123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Doctor Profile (View Only)'),
        backgroundColor: const Color.fromARGB(255, 140, 207, 88),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      child: const Icon(Icons.person, size: 50, color: Colors.blue),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Username Field (View Only)
              TextFormField(
                controller: usernameController,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.orange[100],
                ),
              ),
              const SizedBox(height: 16),

              // Doctor Registration Number Field (View Only)
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

              // Email Field (View Only)
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

              // Phone Number Field (View Only)
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

              // Password Field (View Only)
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
      ),
    );
  }
}
