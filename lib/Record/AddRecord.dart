import 'package:flutter/material.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({super.key});

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {

  final _deckName = TextEditingController();
  String isSelectedValue1 = '⭕️';
  String isSelectedValue2 = '先攻';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('戦績入力ページ'),
      ),
      body: Column(
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
              Flexible(
                child: TextField(
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text('・'),
              Flexible(
                child: TextField(),
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
                  value: isSelectedValue1,
                  onChanged: (String? value) {
                    setState(() {
                      isSelectedValue1 = value!;
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
                  value: isSelectedValue2,
                  onChanged: (String? value) {
                    setState(() {
                      isSelectedValue2 = value!;
                    });
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
