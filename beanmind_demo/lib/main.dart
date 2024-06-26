import 'package:beanmind_demo/build_layout_demo.dart';
import 'package:beanmind_demo/catch_the_number_game_page.dart';
import 'package:beanmind_demo/drag_and_drop_only_page.dart';
import 'package:beanmind_demo/drag_and_drop_page.dart';
import 'package:beanmind_demo/home_page.dart';
import 'package:beanmind_demo/math_game_page.dart';
import 'package:beanmind_demo/maze_game_page.dart';
import 'package:beanmind_demo/question_voice_answer_page.dart';
import 'package:beanmind_demo/question_voice_multi_answer_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beanmind Webapp',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      debugShowCheckedModeBanner: false,
      home: BuildLayoutDemo(),
    );
  }
}
