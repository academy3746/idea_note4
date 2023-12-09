import 'package:flutter/material.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/data/idea_info.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    this.ideaInfo,
  });

  static const String routeName = "/edit";

  final IdeaInfo? ideaInfo;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
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
          "새 아이디어 작성하기",
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16,
          ),
        ),
      ),
    );
  }
}
