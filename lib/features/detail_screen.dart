import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/data/db_helper.dart';
import 'package:idea_note4/data/idea_info.dart';
import 'package:idea_note4/features/edit_screen.dart';

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
                          Navigator.pop(context, "delete");
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                margin: const EdgeInsets.all(Sizes.size20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 1. 아이디어를 떠올린 계기
                    const Text(
                      "아이디어를 떠올린 계기",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: Sizes.size5,
                        bottom: Sizes.size30,
                      ),
                      child: Text(
                        widget.ideaInfo!.motive,
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),

                    /// 2. 아이디어 내용
                    const Text(
                      "아이디어 내용",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: Sizes.size5,
                        bottom: Sizes.size30,
                      ),
                      child: Text(
                        widget.ideaInfo!.content,
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),

                    /// 3. 아이디어 중요도 점수
                    const Text(
                      "아이디어를 중요도 점수",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: Sizes.size5,
                        bottom: Sizes.size30,
                      ),
                      child: RatingBar.builder(
                        initialRating: widget.ideaInfo!.importance.toDouble(),
                        itemCount: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemSize: Sizes.size36,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                        ignoreGestures: true,
                        updateOnDrag: false,
                        itemBuilder: (context, index) {
                          return const FaIcon(
                            FontAwesomeIcons.star,
                            color: Colors.amberAccent,
                          );
                        },
                        onRatingUpdate: (value) {},
                      ),
                    ),

                    /// 4. 유저 피드백 사항
                    const Text(
                      "유저 피드백 사항",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: Sizes.size5,
                        bottom: Sizes.size30,
                      ),
                      child: Text(
                        (widget.ideaInfo!.feedback).isEmpty
                            ? "아직 피드백이 없습니다."
                            : widget.ideaInfo!.feedback,
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 5. Confirm Button
          GestureDetector(
            onTap: () async {
              var result = await Navigator.pushNamed(
                context,
                EditScreen.routeName,
                arguments: widget.ideaInfo,
              );

              if (result != null) {
                if (!mounted) return;
                Navigator.pop(context, "update");
              }
            },
            child: Container(
              margin: const EdgeInsets.all(Sizes.size20),
              decoration: ShapeDecoration(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(Sizes.size10),
                ),
              ),
              height: Sizes.size64,
              alignment: Alignment.center,
              child: const Text(
                "수정하기",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
