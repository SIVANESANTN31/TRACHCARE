import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/Addvideos.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/patientslist.dart';
import "package:trachcare/components/Appbar.dart";
import '../../../../components/Navbardrawer.dart';
import '../../../../style/utils/Dimention.dart';
import '../Adminscreens/Doctorlist.dart'; 

class Admindb extends StatelessWidget {
   Admindb({super.key});
   
  List imgList = [
    'Vector',
    'Vector-1',
    'Vector-2',
    // 'video.fill.badge.plus',
    // 'Adddoctor',
    // 'Addpatients',
    // 'Doctor_list1',
    // '2',

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
        patients_list(doctor_id: '88555',),
    ];
        Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: Appbar(Name: "rajieswari", height: dn.height(12),),
       drawer: drawer(
        Name: 'rajieswari',
          
          reg_no: 'regno',
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
                                    Image.asset("assets/images/${imgList[index]}.png", width: 70, height: 70,),),
                                    const SizedBox(height: 20,),
                                    Text(
                                      pages_name[index],
                                      style: TextStyle(
                                        fontSize: 13,
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