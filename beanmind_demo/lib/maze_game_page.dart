import 'package:beanmind_demo/question_popup.dart';
import 'package:flutter/material.dart';

class MazeGamePage extends StatefulWidget {
  @override
  _MazeGamePageState createState() => _MazeGamePageState();
}

class _MazeGamePageState extends State<MazeGamePage> {
  final int rows = 7;
  final int columns = 7;
  late List<List<int>> maze;
  late List<List<bool>> questionCells;
  int playerRow = 0;
  int playerCol = 0;
  int prevPlayerRow = 0;
  int prevPlayerCol = 0;

  @override
  void initState() {
    super.initState();
    maze = List.generate(rows, (i) => List.generate(columns, (j) => 0));
    questionCells = List.generate(rows, (i) => List.generate(columns, (j) => false));
    // Tạo các con đường trong mê cung và các ô câu hỏi
    generateMaze();
    generateQuestionCells();
  }

  void generateMaze() {
    // Tạo các con đường có thể đi và các vật cản
    List<List<int>> paths = [
      [0, 0], [0, 1], [1, 1], [2, 1], [2, 2], [3, 2], [3, 3], [4, 3], [5, 3], [5, 4], [5, 5], [6, 5], [6, 6],
      [1, 2], [1, 3], [1, 4], [2, 4], [3, 4], [3, 5], [4, 5], [4, 6], [0, 3], [0, 4], [1, 4], [2, 4], [2, 5]
    ];
    for (var path in paths) {
      maze[path[0]][path[1]] = 1;
    }
  }

  void generateQuestionCells() {
    // Xác định các ô sẽ hiển thị popup câu hỏi
    List<List<int>> questionPositions = [
      [0, 1], [2, 2], [3, 4], [5, 3], [6, 5]
    ];
    for (var pos in questionPositions) {
      questionCells[pos[0]][pos[1]] = true;
    }
  }

  void movePlayer(int row, int col) {
    if (row >= 0 && row < rows && col >= 0 && col < columns && maze[row][col] == 1) {
      setState(() {
        prevPlayerRow = playerRow;
        prevPlayerCol = playerCol;
        playerRow = row;
        playerCol = col;
      });
      if (questionCells[row][col]) {
        showDialog(
          context: context,
          builder: (BuildContext context) => QuestionPopup(onAnswerSelected: (bool correct) {
            if (correct) {
              Navigator.of(context).pop();
            } else {
              setState(() {
                playerRow = prevPlayerRow;
                playerCol = prevPlayerCol;
              });
            }
          }),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maze Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(rows, (row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(columns, (col) {
                Color color;
                if (row == playerRow && col == playerCol) {
                  color = Colors.green;
                } else if (questionCells[row][col]) {
                  color = Colors.red;
                } else if (maze[row][col] == 1) {
                  color = Colors.white;
                } else {
                  color = Colors.black;
                }
                return GestureDetector(
                  onTap: () => movePlayer(row, col),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: color,
                    margin: EdgeInsets.all(2),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}