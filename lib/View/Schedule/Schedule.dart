import 'package:flutter/material.dart';
import 'package:pokeka_2/Domain/schedule.dart';
import 'package:pokeka_2/Model/Schedule/ScheduleModel.dart';
import 'package:pokeka_2/View/Schedule/AddSchedule.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ScheduleModel>(
      create: (_) => ScheduleModel()..fetchSchedule(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('出場予定イベント'),
        ),

        // addボタンを追加
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            // フローティングアクションボタンを押された時の処理.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSchedulePage(),
                fullscreenDialog: true,
              ),
            )
          },
          child: Icon(Icons.add_box),
        ),
        body: Center(
          child: Consumer<ScheduleModel>(builder: (context, model, child) {
            final List<DomainSchedule>? schedules = model.schedules;

            if (schedules == null) {
              // クルクル回るやつ
              return CircularProgressIndicator();
            }

            // !: 絶対に値がある
            final List<Widget> widgets = schedules.map(
                (schedule) => Card(
                  child: ListTile(
                    // onTap: ,
                    title: Text(schedule.tournamentName),
                    subtitle: Text(schedule.memo),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                          MaterialPageRoute(builder: (context) => AddSchedulePage(

                          ))
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                )
            ).toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
      ),
    );
  }
}