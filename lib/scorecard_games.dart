import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qurankhwani/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ScorecardGames extends StatefulWidget {
  var name;
ScorecardGames(this.name);

  @override
  State<ScorecardGames> createState() => _ScorecardGamesState();
}

class _ScorecardGamesState extends State<ScorecardGames> {
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
                margin: EdgeInsets.only(left: 45),
                child: Text(
                  widget.name,
                  style: TextStyle(
                      color: HexColor("#ffde59"),
                      fontFamily: 'Schyler',
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
         
          FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('GameResult')
                          .where('gameName', isEqualTo: widget.name).orderBy('points',descending: true)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              var user = ds['userName'];
                              var userPoint = ds['points'].toString();
                              return Card(
                        color: HexColor("#ffde59"),
                        child: ListTile(
                          title: Text(
                            user,
                            style: TextStyle(
                              color: HexColor("#2a6e2d"),
                              fontSize: textFontSize,
                              fontFamily: 'Schyler',
                            ),
                          ),
                          trailing: Text(userPoint,style: TextStyle(fontWeight: FontWeight.bold),)
                        ),
                      );
                            });
                      }),



            
        ],
      ),
    ));
  }
}