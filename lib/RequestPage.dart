import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  var id;

  RequestPage(this.id);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const Text(
              "Members",
              style: TextStyle(fontSize: 25, fontFamily: 'Schyler'),
            )),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Request')
                .where('groupID', isEqualTo: widget.id)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    var userID = ds['userID'];
                    var userName = ds['userName'];
                    return Card(
                      child: ListTile(
                        title: Text(userName),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('Request')
                                .where('groupID', isEqualTo: widget.id)
                                .where('userID', isEqualTo: userID)
                                .get()
                                .then((value) => value.docs.forEach((element) {
                                      FirebaseFirestore.instance
                                          .collection('Request')
                                          .doc(element.id)
                                          .delete();
                                    }));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget));
                          },
                        ),
                      ),
                    );
                  });
            }));
  }
}
