import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qurankhwani/GameOptionPage.dart';
import 'package:qurankhwani/GamePageView.dart';
import 'package:qurankhwani/GuessTheVoice.dart';
import 'package:qurankhwani/QaidaPageView.dart';
import 'package:qurankhwani/dragAndDrop.dart';
import 'package:qurankhwani/jigsawPuzzle.dart';
import 'package:qurankhwani/main.dart';
import 'package:qurankhwani/homeScreen.dart' as data;
import 'package:qurankhwani/quess_the_meaning.dart';
import 'package:qurankhwani/scorecard_games.dart';
import 'package:qurankhwani/suduko_puzzle.dart';
import 'package:qurankhwani/wordle.dart';

class GameLists extends StatefulWidget {
  const GameLists({super.key});

  @override
  State<GameLists> createState() => _GameListsState();
}

class _GameListsState extends State<GameLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/image/background.jpg"),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu_open, color: HexColor("#ffde59")),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 65),
                child: Text(
                  "Game Lists",
                  style: TextStyle(
                      color: HexColor("#ffde59"),
                      fontFamily: 'Schyler',
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              SizedBox(
                height: 6,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameOption('Game')),
                  );
                },
                child: Card(
                  color: HexColor("#ffde59"),
                  child: ListTile(
                    title: Text(
                      'Quran Quiz',
                      style: TextStyle(
                        color: HexColor("#2a6e2d"),
                        fontSize: textFontSize,
                        fontFamily: 'Schyler',
                      ),
                    ),
                    trailing: IconButton(
                      icon:
                          Icon(IconData(0x1F3C6, fontFamily: 'MaterialIcons')),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ScorecardGames('Quran Quiz'),
                            ));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GameOption('Guess the Voice')),
              );
            },
            child: Card(
              color: HexColor("#ffde59"),
              child: ListTile(
                title: Text(
                  'Guess the Voice',
                  style: TextStyle(
                    color: HexColor("#2a6e2d"),
                    fontSize: textFontSize,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(IconData(0x1F3C6, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScorecardGames('Guess the Voice'),
                          ));
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JigsawPuzzles()),
              );
            },
            child: Card(
              color: HexColor("#ffde59"),
              child: ListTile(
                title: Text(
                  'Jigsaw Puzzle',
                  style: TextStyle(
                    color: HexColor("#2a6e2d"),
                    fontSize: textFontSize,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(IconData(0x1F3C6, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScorecardGames('Jigsaw Puzzles'),
                          ));
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuesstheMeaning()),
              );
            },
            child: Card(
              color: HexColor("#ffde59"),
              child: ListTile(
                title: Text(
                  'Guess the Meaning',
                  style: TextStyle(
                    color: HexColor("#2a6e2d"),
                    fontSize: textFontSize,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(IconData(0x1F3C6, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScorecardGames('Guess the Meaning'),
                          ));
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WordPuzzleScreen()),
              );
            },
            child: Card(
              color: HexColor("#ffde59"),
              child: ListTile(
                title: Text(
                  'Guess the Words Puzzle',
                  style: TextStyle(
                    color: HexColor("#2a6e2d"),
                    fontSize: textFontSize,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(IconData(0x1F3C6, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScorecardGames('Search Words'),
                          ));
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DragAndDrop()),
              );
            },
            child: Card(
              color: HexColor("#ffde59"),
              child: ListTile(
                title: Text(
                  'Drag And Drop',
                  style: TextStyle(
                    color: HexColor("#2a6e2d"),
                    fontSize: textFontSize,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(IconData(0x1F3C6, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScorecardGames('Drag and Drop'),
                          ));
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WordleGame()),
              );
            },
            child: Card(
              color: HexColor("#ffde59"),
              child: ListTile(
                title: Text(
                  'Wordle',
                  style: TextStyle(
                    color: HexColor("#2a6e2d"),
                    fontSize: textFontSize,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(IconData(0x1F3C6, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScorecardGames('Wordle'),
                          ));
                    }),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
