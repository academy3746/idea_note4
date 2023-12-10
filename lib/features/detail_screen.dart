import 'package:flutter/material.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/data/db_helper.dart';
import 'package:idea_note4/data/idea_info.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    this.ideaInfo,
  });

  static const String routeName = "/detail";

  final IdeaInfo? ideaInfo;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final dbHelper = DatabaseHelper();

  Future<void> _setDeleteIdeaInfo(int id) async {
    await dbHelper.initDatabase();

    await dbHelper.deleteIdeaInfo(id);
  }

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
        actions: [
          TextButton(
            onPressed: () {
              /// Delete IdeaInfo
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("주의하세요!"),
                    content: const Text("해당 아이디어를 삭제 하시겠어요?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "취소",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await _setDeleteIdeaInfo(widget.ideaInfo!.id!);

                          if (!mounted) return;
                          Navigator.of(context).pop();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "삭제",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text(
              "삭제",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: Sizes.size16,
              ),
            ),
          ),
        ],
        title: Text(
          widget.ideaInfo!.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(Sizes.size20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
