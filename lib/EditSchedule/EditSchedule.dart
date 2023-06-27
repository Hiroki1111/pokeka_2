import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokeka_2/Domain/schedule.dart';
import 'package:pokeka_2/EditSchedule/EditScheduleModel.dart';
import 'package:pokeka_2/Schedule/Schedule.dart';
import 'package:provider/provider.dart';


class EditSchedulePage extends StatefulWidget {
  final DomainSchedule schedule;
  const EditSchedulePage(this.schedule);

  @override
  State<EditSchedulePage> createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {

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
    return ChangeNotifierProvider<EditScheduleModel>(
      create: (_) => EditScheduleModel(widget.schedule),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('予定編集'),
        ),

        body: Center(
          child: Consumer<EditScheduleModel>(builder: (context, model, child) {
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
                              icon: Icon(Icons.date_range),
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
                          controller: model.tournamentNameController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onChanged: (text) {
                            model.tournamentName = text;
                            model.setTournamentName(text);
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
                        controller: model.memoController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (text) {
                          model.memo = text;
                          model.setMemo(text);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 更新ボタン
                    ElevatedButton.icon(
                      // 値が更新されなかったらボタンが押せない
                      onPressed: model.isUpdated() ? () async {
                        try {
                          Future addSchedule() async {
                            model.tournamentName = model.tournamentNameController.text;
                            model.memo = model.memoController.text;

                            // firestoreのデータを更新
                            await FirebaseFirestore.instance.collection('Users').doc(model.uid)
                                .collection('schedule').doc(widget.schedule.id).update({
                              'tournamentName': model.tournamentName,
                              'memo': model.memo,
                              'date': _date,
                            });
                          }
                          await addSchedule();
                          Navigator.of(context).pop();
                        } catch(e) {
                          final snacBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snacBar);
                        }
                      } : null,
                      icon: Icon(Icons.edit_calendar), //アイコン
                      label: Text('更新する'), //テキスト
                    ),
                    // 削除ボタン
                    ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          Future addSchedule() async {
                            model.tournamentName = model.tournamentNameController.text;
                            model.memo = model.memoController.text;

                            // 前のif文を突破するとfirestoreに追加
                            await FirebaseFirestore.instance.collection('Users').doc(model.uid)
                                .collection('schedule').doc(widget.schedule.id).delete();
                          }
                          await addSchedule();
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
                      icon: Icon(Icons.delete_forever), //アイコン
                      label: Text('削除する'), //テキスト
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}