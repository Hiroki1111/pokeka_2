import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokeka_2/Domain/record.dart';

class RecordModel extends ChangeNotifier {

  final record = FirebaseFirestore.instance.collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid).collection('record').snapshots();

  List<DomainRecord>? records;

  void fetchRecord() {
    record.listen((QuerySnapshot snapshot) {
      final List<DomainRecord> records = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        final String rivalDeckName = data['rivalDeckName'];
        final String attack = data['attack'];
        final String judge = data['judge'];
        return DomainRecord(rivalDeckName, attack, judge);
      }).toList();
      this.records = records;
      notifyListeners();
    });
  }
}

class AddRecordModel extends ChangeNotifier {

  final uid = FirebaseAuth.instance.currentUser?.uid.toString();

  List<String> list = <String>['一撃ルギア', '白ルギア', 'サーナイトex'];

  String judge1 = '⭕️';
  String attack1 = '先攻';
  String? rivalDeckName1;

  String judge2 = '⭕️';
  String attack2 = '先攻';
  String? rivalDeckName2;

  // String judge3 = '⭕️';
  // String attack3 = '先攻';
  // String? rivalDeckName3;
  //
  // String judge4 = '⭕️';
  // String attack4 = '先攻';
  // String? rivalDeckName4;

}