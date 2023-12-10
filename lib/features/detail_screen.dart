import 'package:flutter/material.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/data/idea_info.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    this.ideaInfo,
  });

  static const String routeName = "/detail";

  final IdeaInfo? ideaInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: Sizes.size24,
          ),
        ),
        title: const Text(
          "해병 짜장을 만들어 보아요",
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
