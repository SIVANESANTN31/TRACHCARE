import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:media_kit/media_kit.dart";
import "package:media_kit_video/media_kit_video.dart";
import "package:trachcare/Api/Apiurl.dart";
import "package:trachcare/components/NAppbar.dart";
import "package:trachcare/style/Tropography.dart";
import "package:video_player/video_player.dart";
import "../../../../style/utils/Dimention.dart";
import "video_list.dart";




class video_player extends StatefulWidget {


  final String Videoulrl;
  final String title;
  final String description;
    video_player({super.key, required this.Videoulrl, required this.title, required this.description});

  @override
  State<video_player> createState() => _video_playerState();
}

class _video_playerState extends State<video_player> {



 late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    player.open(Media('https://$ip/Trachcare/${widget. Videoulrl.substring(2)}'));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: "WatchZone",height: dn.height(10), onTap: (){
         Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => Videospage()),(route)=>false);
      },),
      
      body: SingleChildScrollView(
        child: Column(
         
          children: [
            
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Title: ${widget.title}",style: BoldStyle,),
            ),
            SizedBox(
        
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 9.0 / 16.0,
                 
              child: Video(controller: controller),
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
                      "Description:  ${widget.description}",
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
        
             Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Trachcarelogo.jpg', // Change this path if necessary
              height: 100,
              width: 100,
              colorBlendMode: BlendMode.colorBurn,
            ),
            const SizedBox(height: 20),
            const Text("Hope this video will helps you!!"),
          ],
        ),
            )
          ],
        ),
      ),
       
    );
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
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
      ),
    );
  }
}