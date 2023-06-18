import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final db = FirebaseFirestore.instance;
    final schedule = db.collection('Users').doc(uid).collection('schedule').snapshots();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('出場予定イベント'),
      ),

      // addボタンを追加
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // フローティングアクションボタンを押された時の処理.
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ()),
          // )
        },
        child: Icon(Icons.add_box),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: schedule,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  // onTap: ,
                  trailing: IconButton(
                    onPressed: () {
                      // Navigator.push(, route)
                    },
                    icon: Icon(Icons.add_box),
                  ),
                  title: Text(data['']),
                  subtitle: Text(data['']),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}