//import 'package:animated_drawer/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qurankhwani/RecordPage.dart';
import 'package:qurankhwani/SurahLists.dart';
import 'package:qurankhwani/bookmark_page.dart';
import 'package:qurankhwani/duaLists.dart';
import 'package:qurankhwani/group_screen.dart';
import 'package:qurankhwani/home.dart';
import 'package:qurankhwani/homeScreen.dart' as list;
import 'package:qurankhwani/homeScreen.dart';
import 'package:qurankhwani/intro_name.dart';
import 'package:qurankhwani/juzPageView.dart';
import 'package:qurankhwani/main.dart';
import 'package:qurankhwani/pageRoute.dart';
import 'package:qurankhwani/surahPageView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qurankhwani/main.dart' as data;

class JuzList extends StatefulWidget {
  JuzList();

  @override
  State<JuzList> createState() => _JuzListState();
}

class _JuzListState extends State<JuzList> {
  TextEditingController editingController = TextEditingController();

  _buildLastBookmarkView(Color color) {
    //String data = title[1]["surahName"];
    return Center(
      child: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Bookmarks')
                .where("userId", isEqualTo: data.myID)
                .where('state', isEqualTo: 'Juz')
                .orderBy("createdDate", descending: true)
                .limit(3)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return new Center(
                  child: CircularProgressIndicator(),
                );
              if (snapshot.data!.docs.length == 0) {
                return SizedBox(
                  height: 0,
                );
              } else
                return Column(
                  children: [
                    Container(
                      height: 68,
                      child: new ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            //  if (index == 0) {
                            //  return _buildLastView(HexColor("#68A629"));
                            // }
                            //index--;
                            DocumentSnapshot ds = snapshot.data!.docs[index];

                            String title = ds["juzName"];
                            var juzno = ds["juzNo"];
                            var pageno = ds["pageNo"];
                            var verseno = ds["verseno"];
                            var endVerseNo = ds['endVerseNo'];
                            var startVerseNo = ds['startVerseNo'];
                            var position = ds['position'];
                            var value = index + 1;
                            return GestureDetector(
                              child: (title != '')
                                  ? Center(
                                      child: Card(
                                          margin: EdgeInsets.all(8),

                                          //  height: 50,
                                          // width: 100,
                                          color: HexColor("#ffde59"),
                                          child: Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Center(
                                                  child: Text(
                                                      title +
                                                          " " +
                                                          juzno.toString() +
                                                          ":" +
                                                          pageno.toString() +
                                                          ':' +
                                                          verseno.toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            HexColor("#2a6e2d"),
                                                        fontFamily: 'Schyler',
                                                      ))))))
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JuzPageView(
                                            title,
                                            juzno.toString(),
                                            verseno.toString(),
                                            startVerseNo.toString(),
                                            endVerseNo.toString(),
                                            '',
                                            position,
                                            Colors.green)));
                              },
                            );
                          }),
                    ),
                  ],
                );
            }),
      ),
    );
  }

  //   List<String>.generate(114, (i) => quran.getSurahName(i + 1));
  var items = <String>[];
  var itemsAr = <String>[];
  var JuzNo = <String>[];
  var JuzPage = <String>[];
  var JuzEndPages = <String>[];
  var _selectedIndex = 1;
  @override
  void initState() {
    items.addAll(list.JuzNameList);
    itemsAr.addAll(list.JuzArabicNameList);
    JuzNo.addAll(list.JuzNo);
    JuzPage.addAll(list.JuzPages);
    JuzEndPages.addAll(list.JuzEndPages);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    List<String> dummySearchListAr = <String>[];
    List<String> dummySearchJuzNo = <String>[];
    List<String> dummySearchJuzPage = <String>[];
    List<String> dummySearchJuzEndPages = <String>[];
    query.toLowerCase();
    dummySearchList.addAll(list.JuzNameList);
    dummySearchListAr.addAll(list.JuzArabicNameList);
    dummySearchJuzNo.addAll(list.JuzNo);
    dummySearchJuzPage.addAll(list.JuzPages);
    dummySearchJuzEndPages.addAll(list.JuzEndPages);

    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      List<String> dummyListDataAr = <String>[];
      List<String> dummyListJuzNo = <String>[];
      List<String> dummyListJuzPage = <String>[];
      List<String> dummyListJuzEndPages = <String>[];
      for (var i = 0; i < dummySearchList.length; i++) {
        dummySearchList[i].toLowerCase();
        if (dummySearchList[i].toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(dummySearchList[i]);
          dummyListDataAr.add(dummySearchListAr[i]);
          dummyListJuzNo.add(dummySearchJuzNo[i]);
          dummyListJuzPage.add(dummySearchJuzPage[i]);
          dummyListJuzEndPages.add(dummySearchJuzEndPages[i]);
        }
      }
      ;
      setState(() {
        items.clear();
        itemsAr.clear();
        JuzNo.clear();

        JuzPage.clear();
        JuzEndPages.clear();
        items.addAll(dummyListData);
        itemsAr.addAll(dummyListDataAr);
        JuzNo.addAll(dummyListJuzNo);
        JuzPage.addAll(dummyListJuzPage);
        JuzEndPages.addAll(dummyListJuzEndPages);
      });
      return;
    } else {
      setState(() {
        items.clear();
        itemsAr.clear();
        JuzNo.clear();

        JuzPage.clear();
        JuzEndPages.clear();
        items.addAll(list.JuzNameList);
        itemsAr.addAll(list.JuzArabicNameList);
        JuzNo.addAll(list.JuzNo);
        JuzPage.addAll(list.JuzPages);
        JuzEndPages.addAll(list.JuzEndPages);
      });
    }
  }

  void _onItemTapped(int index) async {
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
        MaterialPageRoute(builder: (context) => PageRouteJuzScreen()),
      );
    }

    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RecordJuzPage()),
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
    var textscale = MediaQuery.of(context).textScaleFactor;
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
                  "Juz List",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color: HexColor("#ffde59")),
              cursorColor: HexColor("#ffde59"),
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                labelText: "Search",
                labelStyle: TextStyle(color: HexColor("#ffde59")),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                //suffixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusColor: HexColor("#ffde59"),
                //suffixIconColor: HexColor("#a79162"),
                //iconColor: HexColor("#a79162"),

                //  prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          _buildLastBookmarkView(HexColor("#68A629")),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final display1 =
                    Theme.of(context).textTheme.headline6!.copyWith(
                          color: HexColor("#2a6e2d"),
                          fontSize: arabictextFontSize,
                        );
                return Column(
                  children: [
                    SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        print(items[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JuzPageView(
                                  '${items[index]}',
                                  JuzNo[index].toString(),
                                  '',
                                  JuzPage[index].toString(),
                                  JuzEndPages[index].toString(),
                                  '',
                                  0,
                                  Colors.black)),
                        );
                      },
                      child: Card(
                        color: HexColor("#ffde59"),
                        child: ListTile(
                          trailing: Text(
                            '${itemsAr[index]} ',
                            style: ArabicFonts.lateef(textStyle: display1),
                            // style: TextStyle(
                            //   color: HexColor("#2a6e2d"),
                            //   fontFamily: ArabicFonts.Lateef,
                            //   package: 'google_fonts_arabic',
                            //   fontSize: 30,
                            // ),
                          ),
                          title: Text(
                            '${items[index]} ',
                            style: TextStyle(
                              color: HexColor("#2a6e2d"),
                              fontSize: textFontSize * textscale,
                              fontFamily: 'Schyler',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
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
                          icon: Icon(Icons.list), label: 'Juz List'),
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
    ));
  }
}
