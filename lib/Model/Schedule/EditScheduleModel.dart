import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Domain/schedule.dart';

class EditScheduleModel extends ChangeNotifier {
  final DomainSchedule schedule;
  EditScheduleModel(this.schedule) {
    tournamentNameController.text = schedule.tournamentName;
    memoController.text = schedule.memo;
  }

  final tournamentNameController = TextEditingController();
  final memoController = TextEditingController();

  String? tournamentName;
  String? memo;
  final uid = FirebaseAuth.instance.currentUser?.uid.toString();

  Future update() async {

    if (tournamentName == null || tournamentName!.isEmpty) {
      throw '大会名が入力されていません';
    }

    if (memo == null || memo!.isEmpty) {
      throw '詳細が入力されていません';
    }

    // 前のif文を突破するとfirestoreに追加
    await FirebaseFirestore.instance.collection('Users').doc(uid)
        .collection('schedule').add({
      'tournamentName': tournamentName,
      'memo': memo,
    });
  }
}
