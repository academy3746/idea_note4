import 'package:flutter/material.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/widgets/item_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = "/main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
          itemCount: 10,
          itemBuilder: (context, index) {
            return ItemList(index: index);
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
