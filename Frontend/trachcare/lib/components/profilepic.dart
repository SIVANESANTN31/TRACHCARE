// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Iamgepic{

  void getimage({required ImageSource source}) async {
    final file =
        await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (file != null) {
      
      // final imageBytes = await file.readAsBytes();
      // var base64encoder = base64Encode(imageBytes);
    //   setState(() {
    //     base64encode = base64encoder;
    //   });
    // }

    // if (file?.path != null) {
    //   setState(() {
    //     imagefile = File(file!.path);
    //   });
    // }
    }}

  
}