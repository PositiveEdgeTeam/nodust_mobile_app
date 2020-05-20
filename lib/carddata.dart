import 'package:flutter/material.dart';

import 'Models/contract.dart';
import 'nestedTabBar.dart';

class CardData extends StatefulWidget {
  final Contract current_contract;
  final String customer_id;

  const CardData({Key key, this.current_contract , this.customer_id}) : super(key: key);
  @override
  _CardDataState createState() => _CardDataState(current_contract, customer_id);

}

class _CardDataState extends State<CardData> {
  Contract _current_contract ;
  String _customer_id;
  _CardDataState(this._current_contract, this._customer_id);



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
      body: NestedTabBar(current_contract: _current_contract,customer_id: _customer_id,),

    );
  }
}
