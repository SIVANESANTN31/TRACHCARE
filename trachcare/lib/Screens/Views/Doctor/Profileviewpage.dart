import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:sizer/sizer.dart";

import "profilefeild.dart";
// import 'package:onboarding/utils/profilefield.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 30.h,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 150,
                    left: 30,
                    right: 30,
                    bottom: 0,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Center(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 58,
                                backgroundImage:
                                    AssetImage('assets/images/doctor.png'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const ProfileField(title: 'Username', value: 'XYX'),
                          const SizedBox(height: 20.0),
                          const ProfileField(title: 'Email Id', value: 'XYX@gmail.com'),
                          const SizedBox(height: 20.0),
                          const ProfileField(title: 'Phone Number', value: '123456789'),
                          const SizedBox(height: 20.0),
                          const ProfileField(title: 'Password', value: '123'),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 3,
              ),
              onPressed: () {
                print('Success');
              },
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}