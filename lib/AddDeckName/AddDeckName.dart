import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokeka_2/AddDeckName/AddDeckNameModel.dart';
import 'package:pokeka_2/Graph/Graph.dart';
import 'package:provider/provider.dart';

class AddDeckName extends StatelessWidget {
  AddDeckName({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddDeckNameModel>(
      create: (_) => AddDeckNameModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('デッキ追加'),
        ),
        body: Center(
          child: Consumer<AddDeckNameModel>(builder: (context, model, child) {
            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: 'デッキ名'
                  ),
                  onChanged: (text) {
                    model.mydeckname = text;
                  },
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('Users').doc(model.uid)
                        .collection('mydeck').add({
                      'mydeckname': model.mydeckname,
                    });

                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Graph(),
                      ),
                    );
                  },
                  icon: Icon(Icons.post_add), //アイコン
                  label: Text('追加する'), //テキスト
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}