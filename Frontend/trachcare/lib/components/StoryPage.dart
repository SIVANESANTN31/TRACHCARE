import 'package:flutter/material.dart';
import 'package:trachcare/style/colors.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: TitleColor,
    );
  }
}