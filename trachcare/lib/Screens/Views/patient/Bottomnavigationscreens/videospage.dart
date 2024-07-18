import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/components/NAppbar.dart';

import '../../../../style/colors.dart';

class Videospage extends StatefulWidget {
  const Videospage({super.key});

  @override
  State<Videospage> createState() => _VideospageState();
}

class _VideospageState extends State<Videospage> {
  late final Player player;
  late final VideoController controller;
  bool isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    player = Player();
    controller = VideoController(player);
    player.open(Media('https://youtu.be/38e5IyroBrY?si=QIrs5XZlUQ_pWN1A.mp4')).then((_) {
      setState(() {
        isControllerInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    //controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(
        Title: "Videos",
      ),
      body: isControllerInitialized
          ? ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 20.h,
                    width: 70.w,
                    child: Video(controller: controller),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
