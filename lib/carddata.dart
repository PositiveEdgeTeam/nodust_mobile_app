import 'package:flutter/material.dart';

import 'Models/contract.dart';
import 'nestedTabBar.dart';

class CardData extends StatefulWidget {
  final Contract current_contract;

  const CardData({Key key, this.current_contract}) : super(key: key);
  @override
  _CardDataState createState() => _CardDataState(current_contract);

}

class _CardDataState extends State<CardData> {
  Contract _current_contract ;
  _CardDataState(this._current_contract);



  @override
  void initState() {
    print("cardData");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Data"),
      ),
      body: NestedTabBar(current_contract: _current_contract),
    );
  }
}
