import 'package:flutter/material.dart';

import '../Api/Apiurl.dart';
import '../style/utils/Dimention.dart';

class StoryCircles extends StatelessWidget {
  final function;
  final String url;

   StoryCircles({super.key, this.function, required this.url});

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return GestureDetector(
      onTap: function,
      child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: dn.height(20),
                        width: dn.width(20),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(3.0),
                          child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("https://$ip/Trachcare/$url")
                              ),
                        ),
                       ),
      ),
    );
  }
}