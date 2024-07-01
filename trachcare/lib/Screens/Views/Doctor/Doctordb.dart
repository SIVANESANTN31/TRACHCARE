import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/API_funcation/Login.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/components/Titlebox.dart';
import 'package:trachcare/components/story_circles.dart';
import 'package:trachcare/components/subhead.dart';
import "package:trachcare/components/custom_button.dart";
import 'package:trachcare/Screens/Views/Doctor/Doctordb.dart';
import 'package:trachcare/style/colors.dart';


class Doctordashboard extends StatelessWidget {
      Doctordashboard({super.key});
  //  void _openStory() {
  //   Navigator.push(
  //     context, 
  //     MaterialPageRoute(
  //       builder: (context) => StoryPage(),
  //    ));
  // }

  List imgList = [
    'vector',
    'vector-1',
    'vector-2',
    'video.fill.badge.plus'

  ];
  
  @override
  Widget build(BuildContext context) {
    var currentIndex = 0;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: TitleColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                  Icon(
                    Icons.menu_open_outlined,
                    size: 35,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(left: 3, bottom: 10,top: 20),
                child: Text("Hi, Sivanesan",
                style: TextStyle(
                  fontSize: 25,fontWeight: FontWeight.w600,
                  letterSpacing: 1,wordSpacing: 2, color: Colors.white,
                  ),),
                ),
                  Icon(
                    Icons.notifications,
                    size: 35,
                    color: Colors.white,
                  ),
                  ]
                ),
                SizedBox(height: 20),
                
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 45,),
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
              ], //children 
            ),
          ),
          SizedBox(
                  height: 100,
                  child: ListView.builder(itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return StoryCircles(
                      // function: _openStory,
                    );
                   },
                  ),
                ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Records"
                //       style: TextStyle(
                //         fontSize:  23,
                //         fontWeight: FontWeight.w600,
                //       ),),
                //   ],),
                  // SizedBox(height: 10,),
                  GridView.builder(
                    itemCount: imgList.length,
                    shrinkWrap: true,
                    physics: FixedExtentScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: (MediaQuery.of(context).size.height - 50 - 25)/ (4*240),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){},
                        child: Container(
                          padding: 
                          EdgeInsets.symmetric(vertical: 20, horizontal:  10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 226, 195, 129)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("images/${imgList[index]}.png", width: 100, height: 100,),),
                            
                          ],),
                        ),

                      );
                    },
                    ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
      
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
            ), 
            BottomNavigationBarItem(
            label: "Add Patients",
            icon: Icon(Icons.person),
            ),
             BottomNavigationBarItem(
            label: "Patients List",
            icon: Icon(Icons.person),
            ),
        ],
      ),
    ); 
  }
}