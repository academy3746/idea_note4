import 'package:flutter/material.dart';
import 'package:idea_note4/constants/gaps.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/data/db_helper.dart';
import 'package:idea_note4/data/idea_info.dart';
import 'package:idea_note4/widgets/importance_button.dart';
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

  /// Importance State
  bool isClicked01 = false;
  bool isClicked02 = false;
  bool isClicked03 = true;
  bool isClicked04 = false;
  bool isClicked05 = false;

  /// Selected Importance Score (Default is 3)
  int selectedScore = 3;

  /// Import Database Query Helper
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();

    if (widget.ideaInfo != null) {
      /// TextField Settings
      _titleController.text = widget.ideaInfo!.title;
      _motiveController.text = widget.ideaInfo!.motive;
      _contentController.text = widget.ideaInfo!.content;

      if (widget.ideaInfo!.feedback.isNotEmpty) {
        _feedbackController.text = widget.ideaInfo!.feedback;
      }

      /// Importance Status Settings
      _initClickedStatus();

      switch (widget.ideaInfo!.importance) {
        case 1:
          isClicked01 = true;
          break;

        case 2:
          isClicked02 = true;
          break;

        case 3:
          isClicked03 = true;
          break;

        case 4:
          isClicked04 = true;
          break;

        case 5:
          isClicked05 = true;
          break;
      }

      selectedScore = widget.ideaInfo!.importance;
    }
  }

  /// Screen Touch Keyboard Unfocus
  void _keyboardUnFocus() {
    FocusScope.of(context).unfocus();
  }

  /// Initiate Importance Status
  void _initClickedStatus() {
    isClicked01 = false;
    isClicked02 = false;
    isClicked03 = false;
    isClicked04 = false;
    isClicked05 = false;
  }

  Future<void> _setInsertIdeaInfo(IdeaInfo ideaInfo) async {
    await dbHelper.initDatabase();

    await dbHelper.insertIdeaInfo(ideaInfo);
  }

  Future<void> _setUpdateIdeaInfo(IdeaInfo ideaInfo) async {
    await dbHelper.initDatabase();

    await dbHelper.updateIdeaInfo(ideaInfo);
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
        title: Text(
          widget.ideaInfo == null ? "새 아이디어 작성하기" : "기존 아이디어 수정하기",
          style: const TextStyle(
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
                Container(
                  margin: const EdgeInsets.only(top: Sizes.size10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: ImportanceButton(
                          isClicked: isClicked01,
                          selectedScore: 1,
                        ),
                        onTap: () {
                          _initClickedStatus();

                          setState(() {
                            isClicked01 = true;
                            selectedScore = 1;
                          });
                        },
                      ),
                      GestureDetector(
                        child: ImportanceButton(
                          isClicked: isClicked02,
                          selectedScore: 2,
                        ),
                        onTap: () {
                          _initClickedStatus();

                          setState(() {
                            isClicked02 = true;
                            selectedScore = 2;
                          });
                        },
                      ),
                      GestureDetector(
                        child: ImportanceButton(
                          isClicked: isClicked03,
                          selectedScore: 3,
                        ),
                        onTap: () {
                          _initClickedStatus();

                          setState(() {
                            isClicked03 = true;
                            selectedScore = 3;
                          });
                        },
                      ),
                      GestureDetector(
                        child: ImportanceButton(
                          isClicked: isClicked04,
                          selectedScore: 4,
                        ),
                        onTap: () {
                          _initClickedStatus();

                          setState(() {
                            isClicked04 = true;
                            selectedScore = 4;
                          });
                        },
                      ),
                      GestureDetector(
                        child: ImportanceButton(
                          isClicked: isClicked05,
                          selectedScore: 5,
                        ),
                        onTap: () {
                          _initClickedStatus();

                          setState(() {
                            isClicked05 = true;
                            selectedScore = 5;
                          });
                        },
                      ),
                    ],
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

                /// 아이디어 작성 및 수정 완료
                GestureDetector(
                  onTap: () async {
                    /// 1. 신규 게시글 작성 처리
                    String titleValue = _titleController.text.toString();
                    String motiveValue = _motiveController.text.toString();
                    String contentValue = _contentController.text.toString();
                    String feedbackValue = _feedbackController.text.toString();

                    /// 2. Validate Form Field
                    if (titleValue.isEmpty ||
                        motiveValue.isEmpty ||
                        contentValue.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("반드시 작성해야 하는 필드입니다."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    /// 3. IdeaInfo CREATE
                    if (widget.ideaInfo == null) {
                      var ideaInfo = IdeaInfo(
                        title: titleValue,
                        motive: motiveValue,
                        content: contentValue,
                        importance: selectedScore,
                        feedback: feedbackValue.isNotEmpty ? feedbackValue : "",
                        createDatetime: DateTime.now().millisecondsSinceEpoch,
                      );

                      await _setInsertIdeaInfo(ideaInfo);

                      if (!mounted) return;
                      Navigator.pop(context, "create");

                      /// 4. IdeaInfo UPDATE
                    } else {
                      var updateIdeaInfo = widget.ideaInfo;

                      updateIdeaInfo?.title = titleValue;
                      updateIdeaInfo?.motive = motiveValue;
                      updateIdeaInfo?.content = contentValue;
                      updateIdeaInfo?.importance = selectedScore;
                      updateIdeaInfo?.feedback =
                          feedbackValue.isNotEmpty ? feedbackValue : "";

                      await _setUpdateIdeaInfo(updateIdeaInfo!);

                      if (!mounted) return;
                      Navigator.pop(context, "update");
                    }
                  },
                  child: Container(
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
                    child: Text(
                      widget.ideaInfo == null ? "작성완료" : "수정완료",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
