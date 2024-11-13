import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trachcare/Api/API_funcation/VideoApi.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/Appbar_copy.dart';

import 'VideoPlayer_screen.dart';

/// Creates list of video players
class Videolist extends StatefulWidget {
  const Videolist({super.key});

  @override
  State<Videolist> createState() => _VideolistState();
}

class _VideolistState extends State<Videolist> {
  List Videourls = [];

  @override
  void initState() {
    super.initState();
    FetchVideos();
  }

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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: Duplicate_Appbar(
        Title: "Exercise videos",
        height: screenHeight * 0.1,
      ),
      body: FutureBuilder(
        future: FetchVideos(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List data = snapshot.data;
              if (data.isEmpty) {
                return const Center(
                  child: Text("No videos Available"),
                );
              } else {
                return RefreshIndicator.adaptive(
                  onRefresh: onRefresh,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: screenWidth * 0.05,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => a_videoplayer(
                                  Videoulrl: data[index]["Video_url"].toString(),
                                  description: data[index]["description"].toString(),
                                  title: data[index]["title"].toString(),
                                ),
                              ),
                            );
                          },
                          child: Videocard(
                            data[index]["Thumbnail_url"].toString().substring(2),
                            data[index]["title"].toString(),
                            screenWidth,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 16,
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/error.gif', // Change this path if necessary
                  height: screenHeight * 0.15,
                  width: screenWidth * 0.15,
                ),
                const SizedBox(height: 20),
                const Text("Something went wrong!!"),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget Videocard(String thumbnailUrl, String videoTitle, double screenWidth) {
    double thumbnailHeight = screenWidth * 0.5;
    double fontSize = screenWidth * 0.05;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              "https://$ip/Trachcare/$thumbnailUrl",
              width: double.infinity,
              height: thumbnailHeight,
              fit: BoxFit.cover,
            ),
            IconButton(
              onPressed: () {},
              color: Colors.black54,
              icon: Icon(
                CupertinoIcons.play_circle_fill,
                size: fontSize * 1.5,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  videoTitle,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 2),
      ],
    );
  }
}
