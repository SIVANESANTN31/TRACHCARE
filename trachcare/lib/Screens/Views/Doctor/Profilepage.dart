// ignore_for_file: sort_child_properties_last

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/components/Appbar_copy.dart";
import "package:trachcare/components/custom_button.dart";
// import 'package:editable_image/editable_image.dart';
import "../../../components/NAppbar.dart";
import "../../../style/colors.dart";

class profilepage extends StatelessWidget {
  const profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
             body: Column(
               children: [
                  Stack(
                    children: [
                      Container(
                        height: 30.h,
                        decoration: const BoxDecoration(
                          color: TitleColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:100,left: 30,right: 30,bottom: 0),
                        child: Container(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Profile',),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    radius: 49,
                                    backgroundImage: AssetImage('assets/images/doctor.png'),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Username'),
                                        TextField(
                                          enableInteractiveSelection : false,
                                        decoration:  InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.0,
                                            
                                            ),

                                          ),

                                        ),

                                        ),
                                        
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Username'),
                                        TextField(
                                          enableInteractiveSelection : false,
                                        decoration:  InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.0,
                                            
                                            ),

                                          ),

                                        ),

                                        ),
                                        
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Username'),
                                        TextField(
                                          enableInteractiveSelection : false,
                                        decoration:  InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.0,
                                            
                                            ),

                                          ),

                                        ),

                                        ),
                                        
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Username'),
                                        TextField(
                                          enableInteractiveSelection : false,
                                        decoration:  InputDecoration(
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.0,
                                            
                                            ),

                                          ),

                                        ),

                                        ),
                                        
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          height: 65.h,
                          decoration: const BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        ),
                      ),
                      
                      
                    ],
                  ),
                   const SizedBox(height: 40,),
                  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TitleColor,
                          elevation: 3,
                        ),
                        onPressed: () {
                          print('Success');
                        },
                        child: const Text('Edit Profile',
                                    style: TextStyle(
                                              color: Colors.white,
                      ),
                      )
                      )
               ],
             ),
      );
  }
}