import "package:chewie/chewie.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:trachcare/Api/Apiurl.dart";
import "package:trachcare/components/NAppbar.dart";
import "package:trachcare/style/Tropography.dart";
import "package:video_player/video_player.dart";

import "../../../../style/utils/Dimention.dart";




class video_player extends StatefulWidget {
  //final String Videoulrl;
   const video_player({super.key});

  @override
  State<video_player> createState() => _video_playerState();
}

class _video_playerState extends State<video_player> {

  late ChewieController chewieController;
   Future<void> ? _intialltingvideoplayer; 




final VideoPlayerController _controller = VideoPlayerController.networkUrl(Uri.parse(
        'http://$ip/Trachcare/uploads/videos/477456981614-hd_1920_1080_30fps.mp4'),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true,), // Optional settings
  httpHeaders: {
    
    "Accept": "application/json"
  },
        
        ) ;

  @override
  void initState() {
    super.initState();
    _intialltingvideoplayer = _controller.initialize().then((_) {
    setState(() {
      chewieController = ChewieController(
  videoPlayerController: _controller,
  autoInitialize: true,
  autoPlay: true,
  //materialProgressColors :ChewieProgressColors(playedColor: Colors.white,handleColor: Colors.white),
  showOptions: false,
  showControls: true,
  
);
    }); // Update the UI once the video is initialized.
  });


      
  }




  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: "WatchZone",height: dn.height(10),),
      body:  FutureBuilder(
        future: _intialltingvideoplayer, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState== ConnectionState.done){
          return Center(
            child: Container(
              decoration: BoxDecoration(
                color:const Color.fromARGB(77, 223, 223, 223),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(aspectRatio: _controller.value.aspectRatio,
                child: Chewie(controller: chewieController),
                 
                
                ),
              ),
            ),
          );
        }
        else if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CupertinoActivityIndicator(radius: 12,),);
        }

        return Column(
          children: [
            Text("Something went wrong!!!",style: BoldStyle,)
          ],
        );
        
        
        }),

      // body: _controller.value.isInitialized
      //     ? Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
      //       child: Stack(
      //         alignment: Alignment.center,
      //         children:[ AspectRatio(
      //             aspectRatio: _controller.value.aspectRatio,
      //             child: VideoPlayer(_controller),
      //           ),
      //           IconButton(onPressed: (){
      //              setState(() {
      //           _controller.value.isPlaying
      //               ? _controller.pause()
      //               : _controller.play();
      //         });
      //           }, icon: Icon(
      //         _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //         color: whiteColor,
      //       ),
      //       color: const Color.fromARGB(200, 0, 0, 0),
            
      //       )

      //       //_ControlsOverlay(controller: _controller,)
      //                ] ),
      //     )
      //     : Center(child: CupertinoActivityIndicator(radius: 10,),),
       
    );
  }



  @override
  void dispose() {
   _controller.dispose();
   
    super.dispose();
  }

}


class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : const ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}