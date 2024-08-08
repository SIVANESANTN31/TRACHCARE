import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:video_player/video_player.dart';

import '../../../../style/colors.dart';

class Videospage extends StatefulWidget {
  const Videospage({super.key});

  @override
  State<Videospage> createState() => _VideospageState();
}

class _VideospageState extends State<Videospage> {
  // late final Player player;
  // late final VideoController controller;
  // bool isControllerInitialized = false;
  late VideoPlayerController _controller ;
  late Future<void> _intialltingvideoplayer;
  
  late ChewieController chewiecontroller; 

 

  @override
  void initState() {
    super.initState();
    
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    );

    _intialltingvideoplayer = _controller.initialize().then((_) {
       // _controller.play();
        
          chewiecontroller = ChewieController(
  videoPlayerController: _controller ,
  ////autoPlay: true,
  //looping: true,
);
          
        });
  






  }
   

  @override
  void dispose() {
   // controller.dispose();
    //player.dispose();
    chewiecontroller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(
        Title: "Videos",
      ),
    

      body: FutureBuilder(future: _intialltingvideoplayer, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState== ConnectionState.done){
          return ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {  
            return Padding(
              padding: const EdgeInsets.all(12.0),
              
              child: AspectRatio(aspectRatio: _controller.value.aspectRatio,
              child: Chewie(controller: chewiecontroller,)),
            );
        });
          
      
          
          
        }
        return Center(child: CupertinoActivityIndicator(radius: 10,));
      }),
    
    );
  }
}
