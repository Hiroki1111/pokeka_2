import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddScheduleModel extends ChangeNotifier {
  String? tournamentName;
  String? memo;
  final uid = FirebaseAuth.instance.currentUser?.uid.toString();
}
