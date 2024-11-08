// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/Addvideos.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/patientslist.dart';
import "package:trachcare/components/Appbar.dart";
import '../../../../Api/API_funcation/DashboardApi.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/Navbardrawer.dart';
import '../../../../style/utils/Dimention.dart';
import '../Adminscreens/Doctorlist.dart';
import '../Adminscreens/Profileviewpage.dart'; 

class Admindb extends StatelessWidget {
   Admindb({super.key});
   
  List imgList = [
    'Vector',
    'Vector-1',
    'Vector-2',
  ];

  List pages_name = [
    'Doctors list',
    'Add videos',
    'Patients list',

  ];
  
  get  image => ["assets/images/Vector-1.png"];
  @override
  Widget build(BuildContext context) {
   //bool isOpendrawer = false;
    List pages=[
       const Doctorlist(),
       VideoUploadPage(),
        patients_list(),
    ];
        Dimentions dn = Dimentions(context);
        return FutureBuilder(
      future: AdminDashBoardApi().FetchDetials(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        print(snapshot);
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CupertinoActivityIndicator(radius: 10,),);
        }
        print(snapshot.connectionState);
    if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            var data = snapshot.data;
            var regno = data['doctor_reg_no'].toString();
            print(regno);
            var name  = data['username'].toString();
            var imagepath = data["image_path"].toString().substring(2);
                print(data["image_path"]);
            print(data);

            // Dimentions dn = Dimentions(context);
      return Scaffold(
      appBar: Appbar(Name: name, height: dn.height(12), notification: false,),
       drawer: drawer(
        Name: name,
          reg_no: regno,
          imagepath: NetworkImage("https://$ip/Trachcare/$imagepath"),
          onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) => a_ProfilePage(),),);
      },
      ),

      body: Stack(
      children: [
        // Background image with blur effect
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/5.png'), 
                
              ),
            ),
          ),
        ),
        
        // Scrollable content
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const SizedBox(height: 20,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        itemCount: imgList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                        childAspectRatio: (1.0),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => pages[index],)
                                );
                            },
                            child: Container(
                              padding: 
                              const EdgeInsets.symmetric(vertical: 20, horizontal:  10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    colors: [Color(0XFFFFD9A0), Color(0XFFFFEDD2)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                              ),
                              child: Column(
                                children: [
                                  
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: 
                                    Image.asset("assets/images/${imgList[index]}.png", width: 75, height: 75,),),
                                    SizedBox(height: dn.height(1),),
                                    Text(
                                      pages_name[index],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    )
                                
                              ],),
                            ),
                      
                          );
                        },
                        ),
                    ),
                  ),
              // Add more content as needed
            ],
          ),
        ),
      ],

    ),);
    }
   }
   return Center(child :Text("Something went wrong!!")); });
  }
}