import "package:chewie/chewie.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:trachcare/components/NAppbar.dart";
import "package:trachcare/style/Tropography.dart";
import "package:video_player/video_player.dart";




class video_player extends StatefulWidget {
  const video_player({super.key});

  @override
  State<video_player> createState() => _video_playerState();
}

class _video_playerState extends State<video_player> {

   late VideoPlayerController _controller ;
  late ChewieController chewieController;
  late Future<void> _intialltingvideoplayer; 


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
    );

    _intialltingvideoplayer =  _controller.initialize();
      chewieController = ChewieController(
  videoPlayerController: _controller ,
  fullScreenByDefault : true,
  ////autoPlay: true,
materialProgressColors: ChewieProgressColors(playedColor: Colors.white)
  //looping: true,
);

    
    
    

  }
@override
  void dispose() {
   // controller.dispose();
    //player.dispose();
    chewieController.dispose();
    _controller.dispose();
    super.dispose();
  }


// Future _intialltingvideoplayer() async{
  

// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(Title: "WatchZone"),
      body:  FutureBuilder(
        future: _intialltingvideoplayer, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState== ConnectionState.done){
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: AspectRatio(aspectRatio: _controller.value.aspectRatio,
            child: Chewie(controller: chewieController),
             
            
            ),
          );
        }
        else if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CupertinoActivityIndicator(radius: 12,),);
        }

        return Column(
          children: [
            Text("Something went wrong!!!",style: BoldStyle,)
          ],
        );
        
        
        }),
    );
  }
}