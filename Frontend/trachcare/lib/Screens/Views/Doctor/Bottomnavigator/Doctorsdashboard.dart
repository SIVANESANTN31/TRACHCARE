// import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_carousel_widget/flutter_carousel_widget.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Api/API_funcation/DashboardApi.dart";
import "package:trachcare/Screens/Views/Doctor/doctorscreens/patientreport.dart";
import "package:trachcare/components/Appbar.dart";
import "package:trachcare/components/Navbardrawer.dart";
import "package:trachcare/style/colors.dart";
import "../../../../Api/Apiurl.dart";
import "../../../../components/story_circles.dart";
import "../../../../style/utils/Dimention.dart";
import "../../patient/patientscreens/calender.dart";
import "../doctorscreens/doctorprofile.dart";
import "Addpatients.dart";

class DoctorDashBoard extends StatelessWidget {
  DoctorDashBoard({super.key});

  List imgList = [
    'Vector',
  ];
  List option = [
    'Add new Patient',
  ];

  List<String> img = [
    "assets/images/Images_1.png",
    "assets/images/images_2.png",
    "assets/images/Images_3.png"
  ];
List imagelist = ["assets/images/Vector-1.png"];
  @override
  Widget build(BuildContext context) {
    List pages = [
       Addpatients(),
      // const dailyupdates(),
    ];
    Dimentions dn = Dimentions(context);
    return FutureBuilder(
      future: DoctorDashBoardApi().FetchDetials(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CupertinoActivityIndicator(radius: 10,),);
        }
    if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            var data = snapshot.data["Dashboard"];
            var status = snapshot.data["status"];
            var notification = status.length ==0?false:true;
            List notificationlists = status;
            
            // print(status.runtimeType);
            var regno = data['doctor_reg_no'].toString();
            var name  = data['username'].toString();
            var imagepath = data["image_path"].toString().substring(2);
            

            Dimentions dn = Dimentions(context);
      return Scaffold(
        appBar: Appbar(
          doctor: true,
          Name: name,
          bottom: Bottom(context),
          notificationlists: notificationlists,
          height: dn.height(15), notification: notification,
        ),
        drawer:  drawer(
          Name: name,
          reg_no: regno, 
          imagepath: NetworkImage("https://$ip/Trachcare/$imagepath"),
           onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) => d_ProfilePage(),),);}
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 177, 255, 183),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: dn.height(15),
                child: ListView.builder(
                  itemCount: 15,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return StoryCircles(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DailyUpdatePatients(name: '', imagePath: '',)));
                      },
                    );
                  },
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            SizedBox(
              height: dn.height(15), // Set a specific height as needed
              child: ListView.builder(
                itemCount: imgList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pages[index],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [Color(0XFFFFD9A0), Color(0XFFFFEDD2)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        width: dn.width(70),
                        height: dn.height(10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(imagelist[index]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${option[index]}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
      
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Exercisers For Trach Care:",
                  style: GoogleFonts.ibmPlexSans(
                      textStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0XFF455A64)))),
            ),
      
            carsouleview(img, context),
           
          ],
        ),
      
        
      );
    }
   }
   return Center(child :Text("Something went wrong!!")); });
  }

  PreferredSizeWidget Bottom(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(5.0),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
            child: Container(
                margin: const EdgeInsets.only(
                  top: 0,
                  bottom: 10,
                ),
                width: MediaQuery.of(context).size.width,
                height: 6.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search here....",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                  ),
                )),
          ),
          //  SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget circleButton(
    String time,
  ) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundColor: admin_color,
          ),
        ),
        Text(time)
      ],
    );
  }

  Widget carsouleview(List<String> imagesList, BuildContext context) {
    Dimentions dn = Dimentions(context);

    return SizedBox(
      width: dn.width(100),
      height: dn.height(17),
      child: FlutterCarousel.builder(
        itemCount: imagesList.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Container(
                child: Stack(alignment: Alignment.center, children: [
          Center(
              child: Image.asset(imagesList[itemIndex],
                  fit: BoxFit.cover, width: 1000)),
          const CircleAvatar(
            backgroundColor: Colors.black45,
            child: Icon(
              Icons.play_arrow,
              color: whiteColor,
            ),
          )
        ])),
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayCurve: Curves.easeIn,
          enableInfiniteScroll: true,
        ),
      ),
    );
  }


}