import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokeka_2/Domain/mydeck.dart';

class MydeckModel extends ChangeNotifier {

  final mydeck = FirebaseFirestore.instance.collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid).collection('mydeck').snapshots();

  List<DomainMydeck>? mydecks;

  void fetchMydeck() {
    mydeck.listen((QuerySnapshot snapshot) {
      final List<DomainMydeck> mydecks = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        final String mydeckname = data['mydeckname'];
        return DomainMydeck(mydeckname);
      }).toList();
      this.mydecks = mydecks;
      notifyListeners();
    });
  }
}

class AddDeckNameModel extends ChangeNotifier {
  String? mydeckname;
  final uid = FirebaseAuth.instance.currentUser?.uid.toString();
}