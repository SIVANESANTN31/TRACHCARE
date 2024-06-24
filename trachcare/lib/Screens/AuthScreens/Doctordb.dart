import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/API_funcation/Login.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/components/Titlebox.dart';
import 'package:trachcare/components/subhead.dart';
import "package:trachcare/components/custom_button.dart";
import 'package:trachcare/Screens/AuthScreens/Doctordb.dart';


class Doctordashboard extends StatelessWidget {
  const Doctordashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(0, 192, 255, 154),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Icon(
                    Icons.menu_open_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.white,
                  ),
                  ]
                ),
                SizedBox(height: 20),
                Padding(padding: EdgeInsets.only(left: 3, bottom: 15),
                child: Text("Hi, Sivanesan",
                style: TextStyle(
                  fontSize: 25,fontWeight: FontWeight.w600,
                  letterSpacing: 1,wordSpacing: 2, color: Colors.white,
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here....",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(Icons.search,size: 25,),
                   
                    ),
                  )
                    
                  ),
              ],
            ),
          ),
        ],
      ),
    ); 
  }
}