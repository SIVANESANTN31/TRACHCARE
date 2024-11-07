import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trachcare/Api/API_funcation/VideoApi.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/VideoPlayer_screen.dart';
// import 'package:trachcare/style/colors.dart';
import 'package:trachcare/style/utils/Dimention.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/Appbar_copy.dart';
// import '../../../../style/Tropography.dart';

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
    Dimentions dn = Dimentions(context);
    return Scaffold(
        appBar: Duplicate_Appbar(Title: "Exercise videos", height: dn.height(10)),
        body: FutureBuilder(
            future: FetchVideos(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List data = snapshot.data;
                  print(data);
                  if (data.length == 0) {
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
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => video_player(
                                                  Videoulrl: data[index]["Video_url"].toString(),
                                                  description: data[index]["description"].toString(),
                                                  title: data[index]["title"].toString(),
                                                  
                                                )));
                                  },
                                  child: Videocard(
                                    data[index]["Thumbnail_url"].toString().substring(2),
                                    data[index]["title"].toString(),
                                  )),
                            );
                          }),
                    );
                  }
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    radius: 12,
                  ),
                );
              }

              return const Center(
                child: Text("Something went wrong!!!"),
              );
            }));
  }

  Widget Videocard(String thumbnailUrl, String videoTitle) {
    print(thumbnailUrl);
    // Dimentions dn = Dimentions(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thumbnail
        Image.network(
          "https://$ip/Trachcare/$thumbnailUrl",
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );  
  }
}
