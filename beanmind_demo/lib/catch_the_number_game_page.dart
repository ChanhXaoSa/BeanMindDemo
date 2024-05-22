import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CatchTheNumberGamePage extends StatefulWidget {
  @override
  _CatchTheNumberGamePageState createState() => _CatchTheNumberGamePageState();
}

class _CatchTheNumberGamePageState extends State<CatchTheNumberGamePage> {
  int _score = 0;
  int _num1 = 0;
  int _num2 = 0;
  int _correctAnswer = 0;
  List<int> _fallingNumbers = [0, 0, 0];
  List<double> _positionsY = [0, 0, 0];
  int _playerColumn = 1;
  bool _gameOver = false;

  final Random _random = Random();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _score = 0;
    _generateQuestion();
    _positionsY = [0, 0, 0];
    _playerColumn = 1;
    _gameOver = false;

    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        for (int i = 0; i < _positionsY.length; i++) {
          _positionsY[i] += 5;
          if (_positionsY[i] > MediaQuery.of(context).size.height - 269) {
            _positionsY[i] = 0.0;
            _generateQuestion();
            // _generateFallingNumbers();
          }
        }

        if (_positionsY[_playerColumn] > MediaQuery.of(context).size.height - 270) {
          if (_fallingNumbers[_playerColumn] == _correctAnswer) {
            _score++;
            _generateQuestion();
            _positionsY = [0, 0, 0];
          }
        }
      });
    });
  }

  void _generateQuestion() {
    _num1 = _random.nextInt(10);
    _num2 = _random.nextInt(10);
    _correctAnswer = _num1 + _num2;
    _generateFallingNumbers();
  }

  void _generateFallingNumbers() {
    int correctIndex = _random.nextInt(3);
    for (int i = 0; i < 3; i++) {
      if (i == correctIndex) {
        _fallingNumbers[i] = _correctAnswer;
      } else {
        int wrongAnswer;
        do {
          wrongAnswer = _random.nextInt(20);
        } while (wrongAnswer == _correctAnswer);
        _fallingNumbers[i] = wrongAnswer;
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _movePlayer(int direction) {
    setState(() {
      _playerColumn += direction;
      if (_playerColumn < 0) {
        _playerColumn = 0;
      } else if (_playerColumn > 2) {
        _playerColumn = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double columnWidth = screenWidth / 3;

    return Scaffold(
      appBar: AppBar(
        title: Text('Math Game'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Score: $_score', style: TextStyle(fontSize: 24)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$_num1 + $_num2 = ?', style: TextStyle(fontSize: 24)),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: _positionsY[0],
                  left: 0,
                  child: Container(
                    width: columnWidth,
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text(
                          '${_fallingNumbers[0]}',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _positionsY[1],
                  left: columnWidth,
                  child: Container(
                    width: columnWidth,
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text(
                          '${_fallingNumbers[1]}',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _positionsY[2],
                  left: columnWidth * 2,
                  child: Container(
                    width: columnWidth,
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text(
                          '${_fallingNumbers[2]}',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: _playerColumn * columnWidth + columnWidth / 2 - 25,
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.red,
                    child: Center(
                      child: Icon(Icons.person, size: 36, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () => _movePlayer(-1),
            child: Icon(Icons.arrow_left),
          ),
          FloatingActionButton(
            onPressed: () => _movePlayer(1),
            child: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}