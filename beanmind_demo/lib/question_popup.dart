import 'package:flutter/material.dart';
import 'dart:math';

class QuestionPopup extends StatelessWidget {
  final Function(bool) onAnswerSelected;

  QuestionPopup({required this.onAnswerSelected});

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int a = random.nextInt(10);
    int b = random.nextInt(10);
    int correctAnswer = a + b;
    List<int> options = [
      correctAnswer,
      random.nextInt(20),
      random.nextInt(20),
      random.nextInt(20),
    ]..shuffle();

    return AlertDialog(
      title: Text('Solve the problem'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$a + $b = ?'),
          ...options.map((option) {
            return ElevatedButton(
              onPressed: () {
                onAnswerSelected(option == correctAnswer);
              },
              child: Text(option.toString()),
            );
          }).toList(),
        ],
      ),
    );
  }
}
