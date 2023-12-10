import 'package:flutter/material.dart';
import 'package:idea_note4/data/idea_info.dart';
import 'package:idea_note4/features/detail_screen.dart';
import 'package:idea_note4/features/edit_screen.dart';
import 'package:idea_note4/features/main_screen.dart';
import 'package:idea_note4/features/splash_screen.dart';

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IDEA NOTE',
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
        useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == EditScreen.routeName) {
          /// 1. 새 글 작성 Scenario
          final IdeaInfo? ideaInfo = settings.arguments as IdeaInfo?;

          return MaterialPageRoute(
            builder: (context) {
              return EditScreen(ideaInfo: ideaInfo);
            },
          );

          /// 2. 기존 글 수정 Scenario
        } else if (settings.name == DetailScreen.routeName) {
          final IdeaInfo? ideaInfo = settings.arguments as IdeaInfo?;

          return MaterialPageRoute(
            builder: (BuildContext context) {
              return DetailScreen(ideaInfo: ideaInfo);
            },
          );
        }

        return null;
      },
    );
  }
}
