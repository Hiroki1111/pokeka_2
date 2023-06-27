import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokeka_2/Domain/schedule.dart';

class ScheduleModel extends ChangeNotifier {

  final schedule = FirebaseFirestore.instance.collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid).collection('schedule').snapshots();

  List<DomainSchedule>? schedules;

  void fetchSchedule() {
      schedule.listen((QuerySnapshot snapshot) {
      final List<DomainSchedule> schedules = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        // final String id = data['id'];
        final String tournamentName = data['tournamentName'];
        final String memo = data['memo'];
        final String id = document.id;
        return DomainSchedule(id, tournamentName, memo);
      }).toList();
      this.schedules = schedules;
      notifyListeners();
    });
  }
}