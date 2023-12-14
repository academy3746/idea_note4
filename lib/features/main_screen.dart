import 'package:flutter/material.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/data/db_helper.dart';
import 'package:idea_note4/data/idea_info.dart';
import 'package:idea_note4/features/detail_screen.dart';
import 'package:idea_note4/features/edit_screen.dart';
import 'package:idea_note4/widgets/item_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = "/main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<IdeaInfo> lstIdeaInfo = [];

  var dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();

    _getIdeaInfo();
    //insertDummyData();
  }

  /// 기열찐빠 더미 데이터
  Future<void> insertDummyData() async {
    await dbHelper.initDatabase();

    await dbHelper.insertIdeaInfo(
      IdeaInfo(
        title: "해병 수육을 만들어 보아요",
        motive: "기열 찐빠 근절을 위해",
        content: "기열 황룡을 해병 수육으로 만들어 보자!",
        importance: 4,
        feedback: "따흐아앙!!!",
        createDatetime: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  /// SELECT * FROM `write_idea` WHERE (1) ORDER BY createDatetime DESC
  Future<void> _getIdeaInfo() async {
    await dbHelper.initDatabase();

    lstIdeaInfo = await dbHelper.getAllIdeaInfo();

    lstIdeaInfo.sort((a, b) => b.createDatetime.compareTo(a.createDatetime));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "IDEA NOTE",
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size32,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(Sizes.size20),
        child: ListView.builder(
          itemCount: lstIdeaInfo.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                var result = await Navigator.pushNamed(
                  context,
                  DetailScreen.routeName,
                  arguments: lstIdeaInfo[index],
                );

                if (result != null) {
                  String msg = "";

                  /// 1. IdeaInfo UPDATE
                  if (result == "update") {
                    msg = "기존 아이디어가 수정되었습니다.";

                    /// 2. IdeaInfo DELETE
                  } else if (result == "delete") {
                    msg = "기존 아이디어가 삭제되었습니다.";
                  }

                  await _getIdeaInfo();

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                    ),
                  );
                }
              },
              child: ItemList(
                index: index,
                lstIdeaInfo: lstIdeaInfo,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        onPressed: () async {
          var result = await Navigator.pushNamed(context, EditScreen.routeName);

          if (result != null) {
            await _getIdeaInfo();

            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("새로운 아이디어 작성이 완료되었습니다."),
              ),
            );
          }
        },
        child: Image.asset(
          "assets/images/post.png",
          color: Colors.white,
          width: Sizes.size36,
          height: Sizes.size36,
        ),
      ),
    );
  }
}
