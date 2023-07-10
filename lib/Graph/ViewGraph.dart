import 'package:flutter/material.dart';
import 'package:pokeka_2/Domain/mydeck.dart';
import 'package:pokeka_2/Graph/GraphModel.dart';
import 'package:provider/provider.dart';

class ViewGraph extends StatefulWidget {
  const ViewGraph(this.deckname);
  final DomainMydeck deckname;

  @override
  State<ViewGraph> createState() => _ViewGraphState();
}

class _ViewGraphState extends State<ViewGraph> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GraphModel>(
        create: (_) => GraphModel(widget.deckname),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('戦績グラフ'),
          ),
          body: Consumer<GraphModel>(builder: (context, model, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 15.0, left: 10),
                        child: Text(
                          model.deckName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('100'),
                                Text('90'),
                                Text('80'),
                                Text('70'),
                                Text('60'),
                                Text('50'),
                                Text('40'),
                                Text('30'),
                                Text('20'),
                                Text('10'),
                                Text('0'),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        )
    );
  }
}
//                           children: [
//                             Text('100'),
//                             Text('90'),
//                             Text('80'),
//                             Text('70'),
//                             Text('60'),
//                             Text('50'),
//                             Text('40'),
//                             Text('30'),
//                             Text('20'),
//                             Text('10'),
//                             Text('0'),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           for (var index = 0; index < 7; index++)
//                             Padding(
//                               padding: const EdgeInsets.all(4),
//                               // child: ChartItem(
//                               //   ratio: values[index],
//                               //   date:
//                               //   DateTime.now().add(Duration(days: index)),
//                               // ),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         )
//       ),
//     );
//   }
// }
