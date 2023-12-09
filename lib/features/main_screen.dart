import 'package:flutter/material.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/data/db_helper.dart';
import 'package:idea_note4/data/idea_info.dart';
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
            return ItemList(
              index: index,
              lstIdeaInfo: lstIdeaInfo,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        onPressed: () {},
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
