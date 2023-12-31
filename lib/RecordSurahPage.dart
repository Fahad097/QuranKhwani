import 'package:flutter/material.dart';
//import 'package:google_fonts_arabic/fonts.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qurankhwani/bookmark_page.dart';
import 'package:qurankhwani/duaLists.dart';
import 'package:qurankhwani/group_screen.dart';
import 'package:qurankhwani/homeScreen.dart' as list;
import 'package:qurankhwani/homeScreen.dart';
import 'package:qurankhwani/intro_name.dart';
import 'package:qurankhwani/main.dart';
import 'package:qurankhwani/pageRoute.dart';
import 'package:qurankhwani/surahLists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecordSurahPage extends StatefulWidget {
  const RecordSurahPage({Key? key}) : super(key: key);

  @override
  State<RecordSurahPage> createState() => _RecordSurahPageState();
}

class _RecordSurahPageState extends State<RecordSurahPage> {
  @override
  void initState() {
    print(list.surahCount);
    // TODO: implement initState
  }

  var _selectedIndex = 2;
  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  title: 'Quran Khwani',
                )),
      );
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SurahList()),
      );
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RecordSurahPage()),
      );
    }
    if (index == 3) {
      var uservalue = await FirebaseAuth.instance.signInAnonymously();
      var check = 0;
      var data = await FirebaseFirestore.instance
          .collection("Users")
          .where("userID", isEqualTo: uservalue.user?.uid)
          .get()
          .then((value) => check = value.size);
      if (check == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroName('grp')),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GroupScreen(false)),
        );
      }
    }
    if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BookmarkPage()),
      );
    }
    if (index == 5) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DuaLists()),
      );
    }
  }

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
          children: [
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
                  margin: EdgeInsets.only(left: 55),
                  child: Text(
                    "Total Count",
                    style: TextStyle(
                        color: HexColor("#ffde59"),
                        fontFamily: 'Schyler',
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.surahCount.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: HexColor("#ffde59"),
                        child: ListTile(
                          trailing: Text(
                            '${list.surahCount[list.surahNameList[index]]} ',
                            style: TextStyle(
                              color: HexColor("#2a6e2d"),
                              fontSize: 30,
                            ),
                          ),
                          title: Text(
                            '${list.surahNameList[index]} ',
                            style: TextStyle(
                              color: HexColor("#2a6e2d"),
                              fontSize: textFontSize,
                              fontFamily: 'Schyler',
                            ),
                          ),
                        ),
                      );
                    })),
            Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                    data: Theme.of(context)
                        .copyWith(canvasColor: Colors.transparent),
                    child: BottomNavigationBar(
                      elevation: 0,
                      currentIndex: _selectedIndex,
                      onTap: _onItemTapped,
                      selectedItemColor: HexColor("#ffde59"),
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: 'Home'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.list), label: 'Surah List'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.format_list_numbered),
                            label: 'Count'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.group), label: 'Groups'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.bookmark), label: 'bookmarks'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.panorama_fisheye_rounded),
                            label: 'Duas')
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
