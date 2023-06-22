import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokeka_2/Model/Schedule/AddSchedule.dart';
import 'package:pokeka_2/View/Schedule/Schedule.dart';
import 'package:provider/provider.dart';


class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  var _labelText = '';
  DateTime? _date;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      setState(() {
        // 日本語表記
        _date = selected;
        _labelText = (DateFormat.yMMMd("ja")).format(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddScheduleModel>(
      create: (_) => AddScheduleModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('予定追加'),
        ),

        body: Center(
          child: Consumer<AddScheduleModel>(builder: (context, model, child) {
            return Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    SizedBox(
                      width: 20,
                    ),
                    Text('• 日　付：'),
                    SizedBox(
                      width: 300,
                      child: Row(
                        children: [
                          Text(
                            _labelText,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              icon: Icon(Icons.date_range)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text('・大会名：'),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onChanged: (text) {
                            model.tournamentName = text;
                          },
                        ),
                      ),
                    ]
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text('• メ　モ：'),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (text) {
                          model.memo = text;
                        },
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 40)),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await model.addSchedule();
                      FirebaseFirestore.instance.collection('Users')
                          .doc(model.uid).collection('schedule')
                          .add({'date': _date});
                    } catch(e) {
                      final snacBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(e.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snacBar);
                    }

                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Schedule(),
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