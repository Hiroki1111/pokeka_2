import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokeka_2/Graph/AddDeckName.dart';
import 'package:pokeka_2/Graph/ViewGraph.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final db = FirebaseFirestore.instance;
    final DeckName = db.collection('Users').doc(uid).collection('DeckName').snapshots();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('戦績グラフページ'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DeckName,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Stack(
            children: [
              ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  final data = document.data()! as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      // onTap: ,
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewGraph(),
                            )
                          );
                        },
                        icon: Icon(Icons.auto_graph),
                      ),
                      title: Text('${data['DeckName']}'),
                    ),
                  );
                }).toList(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDeckName())
                    );
                  },
                  icon: Icon(Icons.add_box), //アイコン
                  label: Text('追加する'), //テキスト
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}