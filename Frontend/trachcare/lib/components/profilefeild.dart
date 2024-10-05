

import 'package:flutter/material.dart';
class ProfileField extends StatelessWidget {
  final String title;
  final String value;
  const ProfileField({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        const SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(color: Colors.grey,),
          ),
          child: Text(value,style: const TextStyle(fontSize: 16),),
        ),

      ],
    );
  }
}