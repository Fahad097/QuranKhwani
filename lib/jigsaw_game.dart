import 'package:flutter/material.dart';

class PuzzleGame extends StatefulWidget {
  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jigsaw Puzzle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: PuzzleBoard(),
            ),
            SizedBox(height: 20),
            Text('Drag and drop pieces to solve the puzzle'),
          ],
        ),
      ),
    );
  }
}

class PuzzleBoard extends StatefulWidget {
  @override
  _PuzzleBoardState createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  final List<int> pieces = List.generate(25, (index) {
    var i = index + 1;
    print(i);
    return i;
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      itemCount: pieces.length,
      itemBuilder: (BuildContext context, int index) {
        return Draggable<int>(
          data: pieces[index],
          feedback: Image.asset(
            'assets/image/jigsaw/${pieces[index].toString()}.png',
            width: 80,
            height: 80,
          ),
          child: DragTarget<int>(
            builder: (BuildContext context, List<int?> data,
                List<dynamic> rejectedData) {
              return Container(
                width: 80,
                height: 80,
                child: Image.asset(
                  'assets/image/jigsaw/row-${pieces[index].toString()}.png',
                  width: 80,
                  height: 80,
                ),
              );
            },
            onWillAccept: (data) => true,
            onAccept: (data) {
              setState(() {
                pieces.remove(data);
              });

              if (pieces.isEmpty) {
                _showCongratulationsDialog(context);
              }
            },
          ),
        );
      },
    );
  }

  void _showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You solved the puzzle!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  pieces.addAll([0, 1, 2, 3, 4, 5, 6, 7, 8]);
                  pieces.shuffle();
                });
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }
}
