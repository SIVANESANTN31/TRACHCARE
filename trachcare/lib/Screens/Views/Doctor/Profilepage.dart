import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/components/Appbar_copy.dart";
import "package:trachcare/components/custom_button.dart";

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
                        decoration: BoxDecoration(
                          color: TitleColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:100,left: 30,right: 30,bottom: 0),
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                   SizedBox(height: 40,),
                  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TitleColor,
                          elevation: 3,
                        ),
                        onPressed: () {
                          print('Success');
                        },
                        child: Text('Edit Profile',
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