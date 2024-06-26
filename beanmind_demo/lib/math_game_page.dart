import 'dart:math';

import 'package:beanmind_demo/const.dart';
import 'package:beanmind_demo/util/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class MathGamePage extends StatefulWidget {
  @override
  _MathGamePageState createState() => _MathGamePageState();
}

class _MathGamePageState extends State<MathGamePage> {
  final FocusNode _resultFocusNode = FocusNode();
  final AudioPlayer _audioPlayer = AudioPlayer();
  late VideoPlayerController _videoPlayerController;
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
    if (userAnswer.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.deepPurple,
              content: Container(
                height: 400,
                color: Colors.deepPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Incorrect!',
                      style: whiteTextStyle,
                    ),
                    Lottie.asset('assets/lotties/wrong.json', height: 100),
                    Center(
                      child: _videoPlayerController.value.isInitialized
                          ? AspectRatio(aspectRatio: _videoPlayerController.value.aspectRatio, child: VideoPlayer(_videoPlayerController),)
                          : Container(),
                    ),
                    FloatingActionButton(onPressed: () {
                      setState(() {
                        _videoPlayerController.value.isPlaying ?
                        _videoPlayerController.pause() : _videoPlayerController.play();
                      });
                    },
                      child: Icon(_videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow),
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
    }
    ;
    if (numberA + numberB == int.parse(userAnswer)) {
      userPoint += 1;
      _playSuccessSound();
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
                    Lottie.asset('assets/lotties/success.json', height: 100),
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
                height: 400,
                color: Colors.deepPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Incorrect!',
                      style: whiteTextStyle,
                    ),
                    Lottie.asset('assets/lotties/wrong.json', height: 100),
                    Center(
                      child: _videoPlayerController.value.isInitialized
                          ? AspectRatio(aspectRatio: _videoPlayerController.value.aspectRatio, child: VideoPlayer(_videoPlayerController),)
                          : Container(),
                    ),
                    FloatingActionButton(onPressed: () {
                      setState(() {
                        _videoPlayerController.value.isPlaying ?
                        _videoPlayerController.pause() : _videoPlayerController.play();
                      });
                    },
                      child: Icon(_videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow),
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
    }
    ;
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

  void _playSuccessSound() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/success.mp3');
      _audioPlayer.play();
    } catch (e, stacktrace) {
      print('Error playing success sound: $e');
      print(stacktrace);
    }
  }

  @override
  void dispose() {
    _resultFocusNode.dispose();
    _audioPlayer.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((value) => {setState(() {})});
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
                          flex: 4,
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
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            child: GridView.builder(
                                itemCount: numberPad.length,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 0.9),
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
                          flex: 3,
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
                          flex: 2,
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
