
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get_thumbnail_video/index.dart';
// import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:trachcare/Api/API_funcation/VideoApi.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/VideoPlayer_screen.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:trachcare/style/colors.dart';
import 'package:trachcare/style/utils/Dimention.dart';

import '../../../../Api/DataStore/Datastore.dart';
import '../../../../components/Appbar_copy.dart';
import '../../../../style/Tropography.dart';

/// Creates list of video players
class Videolist extends StatefulWidget {
  const Videolist({super.key});

  @override
  State<Videolist> createState() => _VideolistState();
}

class _VideolistState extends State<Videolist> {
  List Videourls = [];
  List thumbnil = [];

  @override
  void initState() {
    super.initState();
    FetchVideos();
  }

  Future FetchVideos() async {
    Videourls = await Video().Fetchvideo(patient_id, Doctor_id);
    Videourls.removeAt(0);
    //  for (int i = 0; i<Videourls.length;i++){
    //    String thumbpath = await gearatevedioThambline(Videourls[i]);
    //    thumbnil.add(thumbpath);

    //   }
    //   print(thumbnil);
    return Videourls;
  }

  // Future gearatevedioThambline(String videourl) async {
  //   XFile thumbnailurl = await VideoThumbnail.thumbnailFile(
  //     video: "http://$ip/$videourl",
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.WEBP,
  //     maxHeight: 64,
  //     quality: 80,
  //   );
  //   return thumbnailurl.path;
  // }

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

                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Future thumblinefilepath =  gearatevedioThambline(data[index]);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const video_player()));
                              },
                              child: Videocard("assets/images/0.png",
                                  "5 Tips for Managing Lung Disease Symptoms")),
                        );
                      });
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    radius: 12,
                  ),
                );
              }

              return const Center(
                child: Text("something went wrong!!!"),
              );
            }));
  }

  Widget Videocard(String ImageUrl, String videoTitle) {
    Dimentions dn = Dimentions(context);
    return Container(
      width: dn.width(78),
      height: dn.height(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(alignment: Alignment.center, children: [
            SizedBox(
                width: dn.width(100),
                height: dn.height(19),
                child: Image(
                  image: AssetImage(ImageUrl),
                  fit: BoxFit.contain,
                )),
            const CircleAvatar(
              backgroundColor: Colors.black45,
              child: Icon(
                Icons.play_arrow,
                color: whiteColor,
              ),
            )
          ]),
          Text(
            videoTitle,
            style: Normal,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
