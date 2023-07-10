import 'package:flutter/cupertino.dart';
import 'package:pokeka_2/Domain/mydeck.dart';

class GraphModel extends ChangeNotifier {
  final DomainMydeck deckname;
  String deckName = '';
  GraphModel(this.deckname) {
    deckName = deckname.mydeckname;
  }
}
