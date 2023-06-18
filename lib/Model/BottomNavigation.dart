import 'package:flutter/material.dart';
import 'package:pokeka_2/View/Graph/Graph.dart';
import 'package:pokeka_2/View/Player/Player.dart';
import 'package:pokeka_2/View/Record/AddRecord.dart';
import 'package:pokeka_2/View/Schedule/Schedule.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static const _screens = [
    Schedule(),
    AddRecord(),
    Graph(),
    Player(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add_outlined), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: ""),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}