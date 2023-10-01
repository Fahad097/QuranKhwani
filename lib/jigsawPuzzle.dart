
import 'package:flutter/material.dart';
import 'package:flutter_jigsaw_puzzle/flutter_jigsaw_puzzle.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qurankhwani/GameResult.dart';
import 'package:qurankhwani/main.dart';

class JigsawPuzzles extends StatefulWidget {
  const JigsawPuzzles({super.key});

  @override
  State<JigsawPuzzles> createState() => JigsawPuzzlesState();
}

class JigsawPuzzlesState extends State<JigsawPuzzles>
    with TickerProviderStateMixin {
  late CustomTimerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CustomTimerController(
      vsync: this,
      begin: const Duration(seconds: 0),
      end: const Duration(hours: 2),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: HexColor("#2a6e2d"), textStyle: const TextStyle(fontSize: 16));
    final puzzleKey = GlobalKey<JigsawWidgetState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: style,
                      onPressed: () async {
                        _controller.reset();
                        _controller.start();
                        await puzzleKey.currentState!.generate();
                      },
                      child: const Text('Generate'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        _controller.pause();
                      },
                      child: const Text('Pause'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        _controller.reset();
                        puzzleKey.currentState!.reset();
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
                CustomTimer(
                    controller: _controller,
                    builder: (state, remaining) {
                      // Build the widget you want!
                      time =
                          "${remaining.hours}:${remaining.minutes}:${remaining.seconds}";
                      var orders = remaining.hours +
                          remaining.minutes +
                          remaining.seconds;
                      order = int.parse(orders);
                      return Text(
                          "${remaining.hours}:${remaining.minutes}:${remaining.seconds}",
                          style: const TextStyle(fontSize: 24.0));
                    }),
                JigsawPuzzle(
                  gridSize: 5,
                  image: const AssetImage('assets/image/jigsaw/jigsaw.png'),
                  onFinished: () {
                    // ignore: avoid_print
                    _controller.reset();
                    var point = 0;
                    if (order < 59) {
                      point = 5;
                    } else if (order < 159 && order > 59) {
                      point = 4;
                    } else if (order < 259 && order > 159) {
                      point = 3;
                    } else if (order < 359 && order > 259) {
                      point = 2;
                    } else {
                      point = 1;
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GameResult('Jigsaw Puzzles', time, point)),
                    );
                    print('finished!');
                  },
                  // ignore: avoid_redundant_argument_values
                  snapSensitivity: .5, // Between 0 and 1
                  puzzleKey: puzzleKey,
                  onBlockSuccess: () {
                    // ignore: avoid_print
                    print('block success!');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
