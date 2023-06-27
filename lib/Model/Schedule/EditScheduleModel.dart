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

  // 大会名or詳細が変更されたら更新される
  bool isUpdated() {
    return tournamentName != null || memo != null;
  }

  // 大会名の値を更新
  void setTournamentName(String tournamentName) {
    this.tournamentName = tournamentName;
    notifyListeners();
  }

  // 詳細の値を更新
  void setMemo(String memo) {
    this.memo = memo;
    notifyListeners();
  }
}
