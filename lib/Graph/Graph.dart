import 'package:flutter/material.dart';
import 'package:pokeka_2/AddDeckName/AddDeckName.dart';
import 'package:pokeka_2/AddDeckName/AddDeckNameModel.dart';
import 'package:pokeka_2/Domain/mydeck.dart';
import 'package:pokeka_2/Graph/ViewGraph.dart';
import 'package:pokeka_2/Record/AddRecord.dart';
import 'package:provider/provider.dart';


class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MydeckModel>(
      create: (_) => MydeckModel()..fetchMydeck(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('戦績デッキ'),
          actions: [
            IconButton(
              onPressed: () async {

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddDeckName()));
              },
              icon: Icon(Icons.add),
            )
          ],
        ),

        // addボタンを追加
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            // フローティングアクションボタンを押された時の処理.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRecord(),
                fullscreenDialog: true,
              ),
            )
          },
          child: Icon(Icons.add_box),
        ),
        body: Center(
          child: Consumer<MydeckModel>(builder: (context, model, child) {
            final List<DomainMydeck>? mydecks = model.mydecks;

            if (mydecks == null) {
              // クルクル回るやつ
              return CircularProgressIndicator();
            }

            // !: 絶対に値がある
            final List<Widget> widgets = mydecks.map(
                    (mydeck) => Card(
                  child: ListTile(
                    // onTap: ,
                    title: Text(mydeck.mydeckname),
                    trailing: IconButton(
                      onPressed: () {
                        // 編集画面に遷移
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                ViewGraph(mydeck),
                            ),
                        );
                      },
                      icon: Icon(Icons.auto_graph),
                    ),
                  ),
                )
            ).toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
      )
    );
  }
}