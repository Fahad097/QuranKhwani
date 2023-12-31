import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qurankhwani/main.dart';


class WordMeaningList extends StatefulWidget {
  const WordMeaningList({super.key});

  @override
  State<WordMeaningList> createState() => _WordMeaningListState();
}

class _WordMeaningListState extends State<WordMeaningList> {
  
  @override
  Widget build(BuildContext context) {
    final display1 =
                    Theme.of(context).textTheme.headline6!.copyWith(
                          color: HexColor("#2a6e2d"),
                          fontSize: arabictextFontSize,
                        );
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
                    "Quranic Words",
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
                child: FutureBuilder(
                                  future: FirebaseFirestore.instance
                                          .collection("words")
                                          .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return new Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    
                                    return  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                       DocumentSnapshot ds = snapshot.data!.docs[index];
                        var arabic = ds['Arabic Word'];
                        var meaning = ds['English Meaning'];
                      return Card(
                        color: HexColor("#ffde59"),
                        child: ListTile(
                          trailing: Text(
                            arabic,
                            style:ArabicFonts.lateef(textStyle: display1),
                          ),
                          title: Text(
                            meaning,
                            style: TextStyle(
                              color: HexColor("#2a6e2d"),
                              fontSize: textFontSize,
                              fontFamily: 'Schyler',
                            ),
                          ),
                        ),
                      );
                    });})),
           
          ],
        ),
      ),
    );
  }
}