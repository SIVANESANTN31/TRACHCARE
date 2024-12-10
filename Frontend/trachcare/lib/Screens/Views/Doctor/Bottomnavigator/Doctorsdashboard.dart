// ignore_for_file: unused_local_variable

import "dart:convert";
import "package:http/http.dart" as http;
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Api/API_funcation/DashboardApi.dart";
import "package:trachcare/components/Appbar.dart";
import "package:trachcare/components/Navbardrawer.dart";
import "package:trachcare/style/colors.dart";
import "../../../../Api/API_funcation/VideoApi.dart";
import "../../../../Api/Apiurl.dart";
import "../../../../Api/DataStore/Datastore.dart";
import "../../../../components/story_circles.dart";
import "../../../../style/utils/Dimention.dart";
import "../doctorscreens/VideoPlayer_screen.dart";
import "../doctorscreens/dailyupdatedetails.dart";
import "../doctorscreens/doctorprofile.dart";
import "Addpatients.dart";
import 'dart:async';

class DoctorDashBoard extends StatefulWidget {
  DoctorDashBoard({super.key});

  @override
  State<DoctorDashBoard> createState() => _DoctorDashBoardState();
}

class _DoctorDashBoardState extends State<DoctorDashBoard> {
  List imgList = [
    'Vector',
  ];

  List option = [
    'Add new Patient',
  ];

 
 

List imagelist = ["assets/images/Vector-1.png"];

 List<dynamic> reports = [];
  bool isLoading = true;
   List Videourls = [];

  Future FetchVideos() async {
    Videourls = await Video().Fetchvideo();
    return Videourls;
  }

  
  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await FetchVideos();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchReports();
    FetchVideos();
  }

  Future<void> fetchReports() async {
    reports = await fetchDailyReport(Doctor_id);
    setState(() {
      isLoading = false;
    });
  }

Future<List<dynamic>> fetchDailyReport(String doctorId) async {
  final String apiUrl = viewstory; // Update this URL

  // Construct the full URL with query parameters
  final Uri uri = Uri.parse('$apiUrl?doctor_id=$doctorId');

  try {
    // Send the GET request
    final response = await http.get(uri);

    // Check the response status
    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> reports = json.decode(response.body);
      print(reports);
      print("sdfghjkl");
      return reports; // Return the list of reports
    } else {
      throw Exception('Failed to load reports: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    return []; // Return an empty list on error
  }
}

  @override
  Widget build(BuildContext context) {
     Dimentions dn = Dimentions(context);
    List pages = [
       Addpatients(),
      // const dailyupdates(),
    ];
    return FutureBuilder(
  future: DoctorDashBoardApi().FetchDetials(),
  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CupertinoActivityIndicator(radius: 10),
      );
    }
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        var data = snapshot.data["Dashboard"];
        var status = snapshot.data["status"];
        var notification = status.length == 0 ? false : true;
        List notificationlists = status;

        var regno = data['doctor_reg_no'].toString();
        var name = data['username'].toString();
        var imagepath = data["image_path"].toString().substring(2);

        Dimentions dn = Dimentions(context);
        return Scaffold(
          appBar: Appbar(
            doctor: true,
            Name: name,
            notificationlists: notificationlists,
            height: dn.height(12),
            notification: notification,
          ),
          drawer: drawer(
            Name: name,
            reg_no: regno,
            imagepath: NetworkImage("https://$ip/Trachcare/$imagepath"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => d_ProfilePage(),
              ));
            },
          ),
          body: RefreshIndicator.adaptive(
            onRefresh: onRefresh,
            child: ListView(
              children: [
                SizedBox(
                  height: dn.height(1),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 177, 255, 183),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: dn.height(13),
                    child: reports.isEmpty
                        ? Center(
                  child:
                      const Text("patients didn't updated today queries."),
                    
                )
                        : ListView.builder(
                            itemCount: reports.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final update = reports[index];
                              return StoryCircles(
                                function: () {
                                  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Viewdailyupdates(
            selecteddate: update['date'].toString().substring(2).split(" ").first,
            patientId: update['patient_id'],
            imagePath: update['image_path'].toString().substring(2),
            name: update['username'],
          ),
        ),
      );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => CalendarScreen(
                                  //       key: UniqueKey(),
                                  //       patientId: update['patient_id'],
                                  //       name: update['username'], // Assuming 'username' is a field in your data
                                  //       imagePath: update['image_path'].toString().substring(2), // Assuming 'image_path' is a field in your data
                                  //     ),
                                  //   ),
                                  // );
                                },
                                url: update['image_path']
                                    .toString()
                                    .substring(2),
                              );
                            },
                          ),
                  ),
                ),
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
                carsouleview(Videourls, context),
              ],
            ),
          ),
        );
      }
    }

    // Display a GIF if something went wrong
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/error.gif', // Change this path if necessary
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20),
          const Text("Something went wrong!!"),
        ],
      ),
    );
  },
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
  
  


Widget carsouleview(List imagesList, BuildContext context) {
  Dimentions dn = Dimentions(context);
  final PageController pageController = PageController();
  Timer? carouselTimer;

  // Set up the timer for automatic scrolling
  void startAutoScroll() {
    carouselTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (pageController.hasClients) {
        int nextPage = pageController.page!.toInt() + 1;
        if (nextPage >= imagesList.length) {
          nextPage = 0; // Loop back to the first page
        }
        pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 3),
          curve: Curves.easeIn,
        );
      }
    });
  }

  // Stop the timer when the widget is disposed
  @override
  void dispose() {
    carouselTimer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  // Start the auto-scrolling when the widget is initialized
  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  return SizedBox(
    width: dn.width(130),
    height: dn.height(55),
    child: FutureBuilder(
      future: FetchVideos(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(radius: 12),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return const Center(child: Text("Failed to load videos!"));
          } else if (snapshot.hasData && snapshot.data != null) {
            List data = snapshot.data;
            if (data.isEmpty) {
              return const Center(child: Text("No videos available"));
            } else {
              return PageView.builder(
                controller: pageController,
                itemCount: data.length < 3 ? data.length : 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => videoplayer(
                            Videoulrl: data[index]["Video_url"]?.toString() ?? "",
                            description: data[index]["description"]?.toString() ?? "",
                            title: data[index]["title"]?.toString() ?? "",
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: dn.width(100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: dn.height(30),
                              width: double.infinity,
                              child: Image.network(
                                'https://$ip/Trachcare/${data[index]["Thumbnail_url"]?.toString().substring(2) ?? ""}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data[index]["title"]?.toString() ?? "Untitled",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Divider(),
                          Center(
                            child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.black,
                                  size: 30.0,
                                  semanticLabel: 'Text to announce in accessibility modes',
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: Text("No videos available"));
          }
        }

        return const Center(child: Text("Something went wrong!!!"));
      },
    ),
  );
}
}