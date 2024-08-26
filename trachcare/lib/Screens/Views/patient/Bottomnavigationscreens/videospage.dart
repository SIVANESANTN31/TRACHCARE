import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/Api/API_funcation/VideoApi.dart';
import 'package:trachcare/Api/Apiurl.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/Screens/Views/patient/Bottomnavigationscreens/VideoPlayer_screen.dart';
import 'package:trachcare/components/NAppbar.dart';
import 'package:trachcare/style/Tropography.dart';
import 'package:video_player/video_player.dart';


import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';

class Videospage extends StatefulWidget {
  const Videospage({super.key});

  @override
  State<Videospage> createState() => _VideospageState();
}

class _VideospageState extends State<Videospage> {
  

 

  @override
  void initState() {
    super.initState();
    
    gearatevedioThambline();

    
  }



 List Videourls=[] ;
  Future gearatevedioThambline() async{
    XFile thumbnailurl  = await VideoThumbnail.thumbnailFile(
  video: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
  thumbnailPath: (await getTemporaryDirectory()).path,
  imageFormat: ImageFormat.PNG,
  maxHeight: 64, 
  quality: 80,
);
Videourls = await Video().Fetchvideo(patient_id,"1");
return File( thumbnailurl.path);
  }


   

 

  @override
  Widget build(BuildContext context) {
    Dimentions dn = new Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(
        Title: "Videos",height: dn.height(10),
      ),
    

      body: FutureBuilder(
        future: gearatevedioThambline(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
             print(Videourls.toString());
            
            return  ListView.builder(
              itemCount: Videourls.length,
              itemBuilder: (BuildContext context, int index) {  
                print(Videourls[index]);
              return 
                            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => video_player(Videoulrl:Videourls[index],)));
                  },
                  
                  child: Videocard(snapshot.data,"5 Tips for Managing Lung Disease Symptoms")),
              );
          });
          }
          }
          else if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CupertinoActivityIndicator(radius: 12,),);
          }
          
          return Center(child: Text("something went wrong!!!"),);
         
  }),
          
      
          
          
       
    );
  }
  
}

Widget Videocard(File ImageUrl,String Video_Title){
  return Container(
    width: 78.w,
    height: 25  .h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
       color: Colors.transparent
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            
            
            SizedBox(
            width: 100.w,
            height: 19.h,
            child: Image(image: FileImage(ImageUrl) ,fit: BoxFit.fill,)
          ),

          CircleAvatar(
            backgroundColor: Colors.black45,
            child: Icon(Icons.play_arrow,color: whiteColor,),
          )
      ]),

        Text(Video_Title,style: Normal,textAlign: TextAlign.justify,)
      ],
    ),
  );

}
