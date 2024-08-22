import 'package:flutter/material.dart';

class StoryCircles extends StatelessWidget {
  final function;

  StoryCircles({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/patient.png"),
                              ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                       ),
      ),
    );
  }
}