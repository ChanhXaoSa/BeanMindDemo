import 'dart:math';

import 'package:beanmind_demo/const.dart';
import 'package:beanmind_demo/util/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MathGamePage extends StatefulWidget {
  @override
  _MathGamePageState createState() => _MathGamePageState();
}

class _MathGamePageState extends State<MathGamePage> {
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0'
  ];

  int numberA = 1;
  int numberB = 2;

  String userAnswer = '';

  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        checkResult();
      } else if (button == 'C') {
        userAnswer = '';
      } else if (button == 'DEL') {
        if(userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 4) {
        userAnswer += button;
      }
    });
  }

  void checkResult() {
    if(numberA + numberB == int.parse(userAnswer)) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          content: Container(
            height: 200,
            color: Colors.deepPurple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Correct!',
                  style: whiteTextStyle,
                ),
                GestureDetector(
                  onTap: goToNextQuestion,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[300],
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                  ),
                )
              ],
            ),
          ),
        );
      });
    } else {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          content: Container(
            height: 200,
            color: Colors.deepPurple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Incorrect!',
                  style: whiteTextStyle,
                ),
                GestureDetector(
                  onTap: goToNextQuestion,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[300],
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                  ),
                )
              ],
            ),
          ),
        );
      });
    };
  }

  var randomNumber = Random();

  void goToNextQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
      numberA = randomNumber.nextInt(2);
      numberB = randomNumber.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Column(
        children: [
          Container(
            height: 160,
            color: Colors.deepPurple,
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      numberA.toString() + ' + ' + numberB.toString() + ' = ',
                      style: whiteTextStyle,
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(style: whiteTextStyle, userAnswer),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: numberPad.length,
                // physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return MyButton(
                    child: numberPad[index],
                    onTap: () => buttonTapped(numberPad[index]),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
