import 'package:flutter/material.dart';
import 'package:idea_note4/constants/gaps.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/data/idea_info.dart';
import 'package:idea_note4/widgets/input_fied.dart';

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
  /// TextField Controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _motiveController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  /// Screen Touch Keyboard Unfocus
  void _keyboardUnFocus() {
    FocusScope.of(context).unfocus();
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
        title: const Text(
          "새 아이디어 작성하기",
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _keyboardUnFocus,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.all(Sizes.size20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 아이디어 제목
                const Text(
                  "제목",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size16,
                  ),
                ),
                InputField(
                  controller: _titleController,
                  fieldHeight: Sizes.size40,
                  verticalPadding: 0,
                  hintText: "아이디어 제목",
                  action: TextInputAction.next,
                ),
                Gaps.v20,

                /// 아이디어 작성 계기
                const Text(
                  "아이디어를 떠올린 계기",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size16,
                  ),
                ),
                InputField(
                  controller: _motiveController,
                  fieldHeight: Sizes.size40,
                  verticalPadding: 0,
                  hintText: "아이디어를 떠올린 계기",
                  action: TextInputAction.next,
                ),
                Gaps.v20,

                /// 아이디어 내용
                const Text(
                  "아이디어 내용",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size16,
                  ),
                ),
                InputField(
                  controller: _contentController,
                  verticalPadding: Sizes.size20,
                  hintText: "떠오른 아이디어를 자세히 작성해 주세요.",
                  maxLines: 5,
                  maxLength: 1000,
                ),
                Gaps.v20,

                /// 아이디어 중요도 점수
                const Text(
                  "아이디어 중요도 점수",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.v20,

                /// 유저 피드백 사항
                const Text(
                  "유저 피드백 사항 (선택)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size16,
                  ),
                ),
                InputField(
                  controller: _feedbackController,
                  verticalPadding: Sizes.size20,
                  hintText: "다른 유저들에게 전달받은\n피드백을 정리해 주세요.",
                  maxLines: 5,
                  maxLength: 500,
                ),
                Gaps.v20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
