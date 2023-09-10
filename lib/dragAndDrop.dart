import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:qurankhwani/GameResult.dart';
import 'package:qurankhwani/main.dart';

class DragAndDrop extends StatefulWidget {
  const DragAndDrop({super.key});

  @override
  State<DragAndDrop> createState() => _DragAndDropState();
}
 


class _DragAndDropState extends State<DragAndDrop>  with TickerProviderStateMixin{
   late CustomTimerController _controller;

final ButtonStyle styleR = ElevatedButton.styleFrom(
        primary: Colors.blueGrey, textStyle: const TextStyle(fontSize: 16));
final ButtonStyle styleS = ElevatedButton.styleFrom(
        primary: Colors.red[300], textStyle: const TextStyle(fontSize: 16));
final ButtonStyle styleC = ElevatedButton.styleFrom(
        primary: Colors.green[300], textStyle: const TextStyle(fontSize: 16));

 List<String> puzzleTiles = [
    'ج',
    'ث',
    'ت',
    'ب',
    'ا',
    'ر',
    'ذ',
    'د',
    'خ',
    'ح',
    'ض',
    'ص',
    'ش',
    'س',
    'ز',
    'ف',
    'غ',
    'ع',
    'ظ',
    'ط',
    'ن',
    'م',
    'ل',
    'ك',
    'ق',
    'ي',
    'ه',
    'و',
     ];
List<String> shuffledTiles = [];

  void swapTiles(int index1, int index2) {
    setState(() {
      final temp = shuffledTiles[index1];
      shuffledTiles[index1] = shuffledTiles[index2];
      shuffledTiles[index2] = temp;
    });
  }

  void resetPuzzle() {
    _controller.reset();
    setState(() {
      puzzleTiles = [
   'ج',
    'ث',
    'ت',
    'ب',
    'ا',
    'ر',
    'ذ',
    'د',
    'خ',
    'ح',
    'ض',
    'ص',
    'ش',
    'س',
    'ز',
    'ف',
    'غ',
    'ع',
    'ظ',
    'ط',
    'ن',
    'م',
    'ل',
    'ك',
    'ق',
    'ي',
    'ه',
    'و',     // Add the remaining puzzle tiles
      ];
        shuffledTiles = List.from(puzzleTiles);
    });
  }
   void shuffleTiles() {
    _controller.start();
    setState(() {
      shuffledTiles = List.from(puzzleTiles);
      shuffledTiles.shuffle();
    });
  }

  bool checkArrangement() {
    for (int i = 0; i < puzzleTiles.length; i++) {
      if (puzzleTiles[i] != shuffledTiles[i]) {
        return false;
      }
    }
    return true;
  }
@override
  void initState() {
    _controller = CustomTimerController(
      vsync: this,
      begin: Duration(seconds: 0),
      end: Duration(hours: 2),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds,
     );
      _controller.reset();
                        _controller.start();
   
    resetPuzzle();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
                child: Text(
                  'Drag and Drop',
                  style: TextStyle(
                      fontFamily: 'Schyler',
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
               CustomTimer(
                controller: _controller,
                builder: (state, remaining) {
                  // Build the widget you want!
                    time = "${remaining.hours}:${remaining.minutes}:${remaining.seconds}";
                   var orders = remaining.hours +remaining.minutes+remaining.seconds;
                    order = int.parse(orders);
                  return Text(
                          "${remaining.hours}:${remaining.minutes}:${remaining.seconds}",
                          style: TextStyle(fontSize: 24.0));
                                   }),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: shuffledTiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DragTarget<int>(
                      onAccept: (data) {
                        swapTiles(data, index);
                      },
                      builder: (BuildContext context, List<dynamic> candidateData, List<dynamic> rejectedData) {
                        return Draggable<int>(
                          data: index,
                          child: Card(
                            color: Colors.grey[100],
                            elevation: 3,
                            child: Center(
                              child: Text(
                                shuffledTiles[index],
                                style: TextStyle( fontSize: 24),
                              ),
                            ),
                          ),
                          feedback: Material(
                            child: Container(
                              color: Colors.green,
                              child: Center(
                                child: Text(
                                  shuffledTiles[index],
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                ElevatedButton(
              style: styleR,
              onPressed: resetPuzzle,
              child: Text('Reset',style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: styleS,
              onPressed: shuffleTiles,
              child: Text('Shuffle',style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: styleC,
              onPressed: () {
                bool isArrangedCorrectly = checkArrangement();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Arrangement Check'),
                      content: Text(isArrangedCorrectly ? 'The tiles are arranged correctly!' : 'The tiles are not arranged correctly.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if(isArrangedCorrectly && order != 0){
                                  var point = 0;
                  if(order < 59){
                    point = 5;
                  }else if(order < 159 && order > 59){
                    point = 4;
                  }else if(order < 259 && order > 159){
                    point = 3;
                  }else if(order < 359 && order > 259){
                    point = 2;
                  }else{
                    point = 1;
                  }
             Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GameResult('Drag and Drop',time,point)),
        );
                            }
                         
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Check Arrangement',style: TextStyle(color: Colors.white),),
            ),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}

