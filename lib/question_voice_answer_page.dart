import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class QuestionVoiceAnswerPage extends StatefulWidget {
  @override
  _QuestionVoiceAnswerPageState createState() => _QuestionVoiceAnswerPageState();
}

class _QuestionVoiceAnswerPageState extends State<QuestionVoiceAnswerPage> {
  FlutterTts flutterTts = FlutterTts();
  String question = "Chữ A là chữ nào aaaaaaa abdafbafdb fsdasdfbadf Triệu gà ?";
  String answer = ""; // store user's answer
  String correctAnswer = "A"; // example correct answer

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 'A',
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value!;
                    });
                  },
                ),
                Text('A'),
                Radio(
                  value: 'B',
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value!;
                    });
                  },
                ),
                Text('B'),
                Radio(
                  value: 'C',
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value!;
                    });
                  },
                ),
                Text('C'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Check answer
                if (answer == correctAnswer) {
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