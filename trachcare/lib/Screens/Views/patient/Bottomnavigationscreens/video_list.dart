// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// /// Creates list of video players
// class Videospage extends StatefulWidget {
//   const Videospage({super.key});

//   @override
//   State<Videospage> createState() => _VideospageState();
// }

// class _VideospageState extends State<Videospage> {
//   final List<YoutubePlayerController> _controllers = [
//     'gQDByCdjUXw',
//     'iLnmTe5Q2Qw',
//     '_WoCV4c6XOE',
//     'KmzdUe0RSJo',
//     '6jZDSSZZxjQ',
//     'p2lYr3vM_1w',
//     '7QUtEmBT_-w',
//     '34_PXCzGw1M',
//   ]
//       .map<YoutubePlayerController>(
//         (videoId) => YoutubePlayerController(
//           initialVideoId: videoId,
//           flags: const YoutubePlayerFlags(
//             autoPlay: false,
//           ),
//         ),
//       )
//       .toList();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video List Demo'),
//       ),
//       body: ListView.separated(
//         itemBuilder: (context, index) {
//           return YoutubePlayer(
//             key: ObjectKey(_controllers[index]),
//             controller: _controllers[index],
//             actionsPadding: const EdgeInsets.only(left: 16.0),
//             bottomActions: const [
//               CurrentPosition(),
//               SizedBox(width: 10),
//               ProgressBar(isExpanded: true),
//               SizedBox(width: 10),
//               RemainingDuration(),
//               FullScreenButton(),
//             ],
//           );
//         },
//         itemCount: _controllers.length,
//         separatorBuilder: (context, _) => const SizedBox(height: 10.0),
//       ),
//     );
//   }
// }