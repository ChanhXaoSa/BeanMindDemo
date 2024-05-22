import 'package:flutter/material.dart';

class DragAndDropPage extends StatefulWidget {
  @override
  _DragAndDropPageState createState() => _DragAndDropPageState();
}

class _DragAndDropPageState extends State<DragAndDropPage> {
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
  List<int> acceptedData = [0,0,0];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Draggable<int>(
              // Data is the value this Draggable stores.
              data: 5,
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
                  child: Text('+5'),
                ),
              ),
            ),
            DragTarget<int>(
              builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                  ) {
                return Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.cyan,
                  child: Center(
                    child: Text('Value : ${acceptedData[0]}'),
                  ),
                );
              },
              onAcceptWithDetails: (DragTargetDetails<int> details) {
                setState(() {
                  acceptedData[0] += details.data;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Draggable<int>(
              // Data is the value this Draggable stores.
              data: 10,
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
                  child: Text('+10'),
                ),
              ),
            ),
            DragTarget<int>(
              builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                  ) {
                return Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.cyan,
                  child: Center(
                    child: Text('Value : ${acceptedData[1]}'),
                  ),
                );
              },
              onAcceptWithDetails: (DragTargetDetails<int> details) {
                setState(() {
                  acceptedData[1] += details.data;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Draggable<int>(
              // Data is the value this Draggable stores.
              data: 25,
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
                  child: Text('+25'),
                ),
              ),
            ),
            DragTarget<int>(
              builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                  ) {
                return Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.cyan,
                  child: Center(
                    child: Text('Value : ${acceptedData[2]}'),
                  ),
                );
              },
              onAcceptWithDetails: (DragTargetDetails<int> details) {
                setState(() {
                  acceptedData[2] += details.data;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}