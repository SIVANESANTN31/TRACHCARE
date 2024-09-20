import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/utils/Dimention.dart';

class UploadVideoPage extends StatefulWidget {
  @override
  _UploadVideoPageState createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  File? _videoFile;
  File? _thumbnailFile;
  final picker = ImagePicker();

  // Function to pick video
  Future<void> _pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _videoFile = File(pickedFile!.path);
    });
  }

  // Function to pick thumbnail
  Future<void> _pickThumbnail() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _thumbnailFile = File(pickedFile!.path);
    });
  }

  // Function to upload video and thumbnail to the server
  Future<void> _uploadVideo() async {
    if (_videoFile == null || _thumbnailFile == null) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
        content: Text('Please select both video and thumbnail!'),
      ));
      return;
    }

    // Prepare the request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Addvideos),
    );

    // Attach the video and thumbnail files
    request.files.add(await http.MultipartFile.fromPath('video', _videoFile!.path, filename: basename(_videoFile!.path)));
    request.files.add(await http.MultipartFile.fromPath('thumbnail', _thumbnailFile!.path, filename: basename(_thumbnailFile!.path)));

    // Send the request
    var response = await request.send();

    // Check response
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
        content: Text('Video uploaded successfully!'),
      ));
    } else {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
        content: Text('Failed to upload video!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
     Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(
        Title: "Doctors List",height: dn.height(10),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Select Video'),
            ),
            _videoFile != null ? Text('Video selected: ${basename(_videoFile!.path)}') : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickThumbnail,
              child: Text('Select Thumbnail'),
            ),
            _thumbnailFile != null ? Text('Thumbnail selected: ${basename(_thumbnailFile!.path)}') : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadVideo,
              child: Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: UploadVideoPage(),
));
