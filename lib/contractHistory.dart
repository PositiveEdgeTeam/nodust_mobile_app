import 'package:flutter/material.dart';
import 'package:nodustmobileapp/Models/cardHistory.dart';

class ContractHistory extends StatefulWidget {
  final  List<CardHistory> contract_history;

  const ContractHistory({Key key, this.contract_history}) : super(key: key);

  @override
  _ContractHistoryState createState() => _ContractHistoryState(this.contract_history);
}

class _ContractHistoryState extends State<ContractHistory> {
  List<CardHistory> _contract_history;

  _ContractHistoryState(this._contract_history);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder
        (
        itemCount: _contract_history.length,
        itemBuilder: (context, i) {
          if(_contract_history[i].historyProducts != null)
             return new ExpansionTile(

              leading: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14),
                child: Icon(
                Icons.local_shipping,
                size: 50.0,
                color: Colors.black26,
              ),
            ),
              title: new Text(
              _contract_history[i].assign_date,
              style: new TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54),
            ),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Status : ", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,color: Colors.black
                ),),
                Text(_contract_history[i].status != null ? _contract_history[i]
                    .status : "",style: TextStyle(color: Colors.black),)
              ],
            ),

            children: <Widget>[
              createTable(_contract_history[i]),
                ],
          );
          else
          return new ExpansionTile(

            leading: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14),
              child: Icon(
                Icons.local_shipping,
                size: 50.0,
                color: Colors.black26,
              ),
            ),
            title: new Text(
              _contract_history[i].assign_date,
              style: new TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54),
            ),
            trailing: Text(""),
            subtitle:  Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Status : ", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,color: Colors.black
                ),),
                Text(_contract_history[i].status != null ? _contract_history[i]
                    .status : "",style: TextStyle(color:Colors.black),)
              ],
            ),

          );
        },
      ),
    );
  }

  Widget createTable(CardHistory policies) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Center(child: Text("Name" ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
      Center(child: Text("Requested",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
      Center(child: Text("Delivered",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)))
    ]));
    for (int i = 0; i < policies.historyProducts.length; ++i) {
      rows.add(TableRow(children: [
        Center(child: Text(policies.historyProducts[i].product_name ,style: TextStyle(fontSize: 15),)),
        Center(child: Text(policies.historyProducts[i].quantity,style: TextStyle(fontSize: 15))),
        Center(child: Text(policies.historyProducts[i].quantity_replaced,style: TextStyle(fontSize: 15)))
      ]));
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Table(children: rows,
      ),
    );
  }

}
