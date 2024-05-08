import 'dart:math';

import 'package:beanmind_demo/const.dart';
import 'package:beanmind_demo/util/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MathGamePage extends StatefulWidget {
  @override
  _MathGamePageState createState() => _MathGamePageState();
}

class _MathGamePageState extends State<MathGamePage> {
  final FocusNode _resultFocusNode = FocusNode();
  bool isFirstKeyEvent = true;
  bool showResultDialog = false;

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
  int userPoint = 0;

  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        checkResult();
      } else if (button == 'C') {
        userAnswer = '';
      } else if (button == 'DEL') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 4) {
        userAnswer += button;
      }
    });
  }

  void handleNumberButtonPress(String number) {
    setState(() {
      if (userAnswer.length < 4) {
        userAnswer += number;
      }
    });
  }

  void checkResult() {
    setState(() {
      showResultDialog = true;
    });
    if(userAnswer.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
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
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
      return;
    };
    if (numberA + numberB == int.parse(userAnswer)) {
      userPoint += 1;
      showDialog(
          context: context,
          builder: (context) {
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
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
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
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
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
    if (showResultDialog) {
      Navigator.of(context).pop();
      setState(() {
        showResultDialog = false;
        userAnswer = '';
        numberA = randomNumber.nextInt(10);
        numberB = randomNumber.nextInt(10);
      });
    }
  }

  @override
  void dispose() {
    _resultFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double thresholdWidth = 600;
    final bool isWideScreen = screenSize.width > thresholdWidth;
    FocusScope.of(context).requestFocus(_resultFocusNode);

    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          final logicalKey = event.logicalKey;
          if (logicalKey == LogicalKeyboardKey.enter) {
            if (showResultDialog) {
              goToNextQuestion();
            } else {
              checkResult();
            }
          } else if (logicalKey == LogicalKeyboardKey.backspace) {
            buttonTapped('DEL');
          }
          final input = logicalKey.keyLabel;
          if (RegExp(r'^[0-9]$').hasMatch(input)) {
            handleNumberButtonPress(input);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.deepPurple[300],
        body: Column(
          children: [
            Container(
              height: 80,
              color: Colors.deepPurple,
              child: Center(
                child: Text(
                  'Total point : ' + userPoint.toString(),
                  style: whiteTextStyle,
                ),
              ),
            ),
            Expanded(
              child: isWideScreen
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              numberA.toString() +
                                  ' + ' +
                                  numberB.toString() +
                                  ' = ' +
                                  userAnswer,
                              style: whiteTextStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: GridView.builder(
                                itemCount: numberPad.length,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1.2),
                                itemBuilder: (context, index) {
                                  return MyButton(
                                    child: numberPad[index],
                                    onTap: () => buttonTapped(numberPad[index]),
                                  );
                                }),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              numberA.toString() +
                                  ' + ' +
                                  numberB.toString() +
                                  ' = ' +
                                  userAnswer,
                              style: whiteTextStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: GridView.builder(
                                itemCount: numberPad.length,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4),
                                itemBuilder: (context, index) {
                                  return MyButton(
                                    child: numberPad[index],
                                    onTap: () => buttonTapped(numberPad[index]),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
            ),
            Focus(
                focusNode: _resultFocusNode,
                child: Container(
                  height: 0,
                  width: 0,
                ))
          ],
        ),
      ),
    );
  }
}