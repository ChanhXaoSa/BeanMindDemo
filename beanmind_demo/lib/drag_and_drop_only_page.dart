import 'package:flutter/material.dart';

class DragAndDropOnlyPage extends StatefulWidget {
  @override
  _DragAndDropOnlyPageState createState() => _DragAndDropOnlyPageState();
}

class _DragAndDropOnlyPageState extends State<DragAndDropOnlyPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Draggable Sample')),
        body: const DraggableExample(),
      ),
    );
  }
}

class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  List<String> acceptedData = ['', '', ''];
  List<bool> dragBool = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            dragBool[0]
                ? SizedBox()
                : Draggable<String>(
                    // Data is the value this Draggable stores.
                    data: 'A',
                    feedback: Container(
                      color: Colors.deepOrange,
                      height: 100,
                      width: 100,
                      child: const Icon(Icons.directions_run),
                    ),
                    childWhenDragging: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.pinkAccent,
                      child: const Center(
                        child: Text('Child When Dragging'),
                      ),
                    ),
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.lightGreenAccent,
                      child: const Center(
                        child: Text('A'),
                      ),
                    ),
                  ),
            DragTarget<String>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return acceptedData[0].isEmpty
                    ? Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.cyan,
                  child: Center(
                    child: Text('${acceptedData[0]}'),
                  ),
                ) : Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.yellow,
                  child: Center(
                    child: Text('${acceptedData[0]}'),
                  ),
                );
              },
              onAcceptWithDetails: (DragTargetDetails<String> details) {
                setState(() {
                  if (acceptedData[0].isEmpty) {
                    acceptedData[0] = details.data;
                    if (details.data == 'A') {
                      dragBool[0] = true;
                    } else if (details.data == 'B') {
                      dragBool[1] = true;
                    } else if (details.data == 'C') {
                      dragBool[2] = true;
                    }
                  }
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            dragBool[1]
                ? SizedBox()
                : Draggable<String>(
                    // Data is the value this Draggable stores.
                    data: 'B',
                    feedback: Container(
                      color: Colors.deepOrange,
                      height: 100,
                      width: 100,
                      child: const Icon(Icons.directions_run),
                    ),
                    childWhenDragging: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.pinkAccent,
                      child: const Center(
                        child: Text('Child When Dragging'),
                      ),
                    ),
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.lightGreenAccent,
                      child: const Center(
                        child: Text('B'),
                      ),
                    ),
                  ),
            DragTarget<String>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return acceptedData[1].isEmpty
                    ?  Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.cyan,
                  child: Center(
                    child: Text('${acceptedData[1]}'),
                  ),
                ) : Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.yellow,
                  child: Center(
                    child: Text('${acceptedData[1]}'),
                  ),
                );
              },
              onAcceptWithDetails: (DragTargetDetails<String> details) {
                setState(() {
                  if (acceptedData[1].isEmpty) {
                    acceptedData[1] = details.data;
                    if (details.data == 'A') {
                      dragBool[0] = true;
                    } else if (details.data == 'B') {
                      dragBool[1] = true;
                    } else if (details.data == 'C') {
                      dragBool[2] = true;
                    }
                  }
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            dragBool[2]
                ? SizedBox()
                : Draggable<String>(
                    // Data is the value this Draggable stores.
                    data: 'C',
                    feedback: Container(
                      color: Colors.deepOrange,
                      height: 100,
                      width: 100,
                      child: const Icon(Icons.directions_run),
                    ),
                    childWhenDragging: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.pinkAccent,
                      child: const Center(
                        child: Text('Child When Dragging'),
                      ),
                    ),
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.lightGreenAccent,
                      child: const Center(
                        child: Text('C'),
                      ),
                    ),
                  ),
            DragTarget<String>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return acceptedData[2].isEmpty
                    ? Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.cyan,
                        child: Center(
                          child: Text('${acceptedData[2]}'),
                        ),
                      )
                    : Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.yellow,
                        child: Center(
                          child: Text('${acceptedData[2]}'),
                        ),
                      );
              },
              onAcceptWithDetails: (DragTargetDetails<String> details) {
                setState(() {
                  if (acceptedData[2].isEmpty) {
                    acceptedData[2] = details.data;
                    if (details.data == 'A') {
                      dragBool[0] = true;
                    } else if (details.data == 'B') {
                      dragBool[1] = true;
                    } else if (details.data == 'C') {
                      dragBool[2] = true;
                    }
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
