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
          itemBuilder: (BuildContext ctxt, int index) {
            return  Container(
              child: Card(
                child:Row(
                  children: <Widget>[
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14),
                      child: Icon(
                        Icons.local_shipping,
                        size: 50.0,
                        color: Colors.black26,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      child: Column(children: <Widget>[
                        Row(children: <Widget>[
                          Text( _contract_history[index].assign_date
                          ),
                        ],
                        ),
                        Row(children: <Widget>[
                          Text("Status : ",style: TextStyle(
                            fontWeight: FontWeight.bold ,
                            fontSize: 15,
                          ),),
                          Text( _contract_history[index].status) ,

                        ],)
                      ],),

                      margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
                    ),
                    Spacer(flex: 1, ),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black26,
                        size: 40.0,
                      ) ,
                      margin: EdgeInsets.symmetric(horizontal: 10 ,vertical: 15),
                    ),


                  ],
                ),
              ) ,
            );
          }
      ),
    );
  }
}
