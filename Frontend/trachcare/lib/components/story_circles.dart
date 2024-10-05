import 'package:flutter/material.dart';

class StoryCircles extends StatelessWidget {
  final function;

  const StoryCircles({super.key, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/patient.png"),
                              ),
                        ),
                       ),
      ),
    );
  }
}