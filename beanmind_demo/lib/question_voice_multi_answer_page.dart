import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class QuestionVoiceMultiAnswerPage extends StatefulWidget {
  @override
  _QuestionVoiceMultiAnswerPageState createState() => _QuestionVoiceMultiAnswerPageState();
}

class _QuestionVoiceMultiAnswerPageState extends State<QuestionVoiceMultiAnswerPage> {
  FlutterTts flutterTts = FlutterTts();
  String question = "Chọn câu có chữ A và chữ B ?";
  List<String> answers = []; // store user's answers
  List<String> correctAnswers = ["A","B"]; // example correct answers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                speak(question);
              },
              child: Text('Nghe đề bài'),
            ),
            SizedBox(height: 20),
            Text(question), // Display question
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text('A'),
              contentPadding: EdgeInsets.symmetric(horizontal: 730 , vertical: 0),
              value: answers.contains('A'),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    answers.add('A');
                  } else {
                    answers.remove('A');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('B'),
              contentPadding: EdgeInsets.symmetric(horizontal: 730 , vertical: 0),
              value: answers.contains('B'),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    answers.add('B');
                  } else {
                    answers.remove('B');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('C'),
              contentPadding: EdgeInsets.symmetric(horizontal: 730 , vertical: 0),
              value: answers.contains('C'),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    answers.add('C');
                  } else {
                    answers.remove('C');
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Check answers
                if (answers.toSet().containsAll(correctAnswers)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Kết quả"),
                        content: Text("Đúng!"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Kết quả"),
                        content: Text("Sai!"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to speak the question
  Future speak(String text) async {
    await flutterTts.setLanguage("vi-VN");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
}
