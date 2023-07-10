import 'package:flutter/material.dart';
import 'package:pokeka_2/Record/AddRecord.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('戦績'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecord()),
          );
        },
        child: Icon(Icons.add_box),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
