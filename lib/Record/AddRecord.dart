import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokeka_2/Graph/Graph.dart';
import 'package:pokeka_2/Record/RecordModel.dart';
import 'package:provider/provider.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({super.key});

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddRecordModel>(
      create: (_) => AddRecordModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('戦績入力ページ'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //
            // )
          },
        ),
        body: Center(
          child: Consumer<AddRecordModel>(builder: (context, model, child) {
            String dropdownValue = model.list.first;
            return Column(
              children: [
                SizedBox(
                  width: 30,
                ),
                TextField(
                  decoration: InputDecoration(
                  hintText: '大会名',
                  border: InputBorder.none
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('使用デッキ：'),
                    DropdownButton(
                      items: model.list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: dropdownValue,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    )
                    // Flexible(
                    //   child: TextField(
                    //   ),
                    // ),
                  ],
                ),

                // 一回戦
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('・'),
                    Flexible(
                      child: TextField(
                        onChanged: (value) {
                          model.rivalDeckName1 = value;
                        },
                      ),
                    ),
                    DropdownButton(
                      items: [
                        DropdownMenuItem(
                          value: '⭕️',
                          child: Text('⭕️'),
                        ),
                        DropdownMenuItem(
                          value: '❌',
                          child: Text('❌'),
                        ),
                      ],
                      value: model.judge1,
                      onChanged: (String? value) {
                        setState(() {
                          model.judge1 = value!;
                        });
                      }
                    ),
                    DropdownButton(
                      items: [
                        DropdownMenuItem(
                          value: '先攻',
                          child: Text('先攻'),
                        ),
                        DropdownMenuItem(
                          value: '後攻',
                          child: Text('後攻'),
                        ),
                      ],
                      value: model.attack1,
                      onChanged: (String? value) {
                        setState(() {
                          model.attack1 = value!;
                          });
                        }
                      ),
                    ],
                  ),

                  // 2回戦
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('・'),
                      Flexible(
                        child: TextField(
                          onChanged: (value) {
                            model.rivalDeckName2 = value;
                          },
                        ),
                      ),
                      DropdownButton(
                          items: [
                            DropdownMenuItem(
                              value: '⭕️',
                              child: Text('⭕️'),
                            ),
                            DropdownMenuItem(
                              value: '❌',
                              child: Text('❌'),
                            ),
                          ],
                          value: model.judge2,
                          onChanged: (String? value) {
                            setState(() {
                              model.judge2 = value!;
                            });
                          }
                      ),
                      DropdownButton(
                          items: [
                            DropdownMenuItem(
                              value: '先攻',
                              child: Text('先攻'),
                            ),
                            DropdownMenuItem(
                              value: '後攻',
                              child: Text('後攻'),
                            ),
                          ],
                          value: model.attack2,
                          onChanged: (String? value) {
                            setState(() {
                              model.attack2 = value!;
                            });
                          }
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection('Users')
                          .doc(model.uid).collection('record').add({
                          'rivalDeckName': model.rivalDeckName1,
                          'judge': model.judge1,
                          'attack': model.attack1,
                      });

                      await FirebaseFirestore.instance.collection('Users')
                          .doc(model.uid).collection('record').add({
                        'rivalDeckName': model.rivalDeckName2,
                        'judge': model.judge2,
                        'attack': model.attack2,
                      });
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => Graph())
                      );
                    },
                  child: Text('追加する'),
                  )
                ],
            );
          }),
        ),
      ),
    );
  }
}
