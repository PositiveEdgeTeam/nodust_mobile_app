import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nodustmobileapp/Models/cardData_.dart';
import 'package:nodustmobileapp/Models/cardDetailResponse.dart';
import 'package:nodustmobileapp/Models/cardDetails.dart';
import 'package:nodustmobileapp/Models/cardsResponse.dart';
import 'package:nodustmobileapp/Models/contract.dart';
import 'package:nodustmobileapp/contractHistory.dart';
import 'package:nodustmobileapp/contractProducts.dart';

import 'contractDetails.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class NestedTabBar extends StatefulWidget {
  final Contract current_contract;
  final String customer_id;
  const NestedTabBar( {Key key, this.current_contract,this.customer_id}) : super(key: key);




  @override
  _NestedTabBarState createState() {
    print(current_contract.card_no+" yyyyy "+customer_id);
    return new _NestedTabBarState(current_contract,customer_id);
  }
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  Contract _current_contract;
  String _customer_id;
  _NestedTabBarState(this._current_contract,this._customer_id);
  CardData_ _currentData;
  final int _startingTabCount = 3;
  bool isSwitched = false;

  List<Widget> _children = [ContractDetails(),ContractDetails(),ContractDetails()];

  @override
  void initState() {
    print("nested");
    loadCardData();
    super.initState();

    _nestedTabController = new TabController(length: _startingTabCount, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Contract No :",style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(_current_contract != null ? _current_contract.card_no :"cardnum"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Next Delivery :",style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(_currentData != null && _currentData.details.next_delivery_date!=null?_currentData.details.next_delivery_date:"dATE"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Status :",style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(_current_contract != null ? _current_contract.status :"status"),
                    SizedBox(width: 2,),
                     Switch(
                       activeColor: Colors.green,
                       value: isSwitched ,
                      onChanged: (value) {
                          showAlertDialog(context, value);
                          //print(isSwitched);
                      },)
                  ],
                ),
                Text(_current_contract != null ? _current_contract.card_value+"EGP" :"cardnum"),
              ],
            ),
          ),
        ),
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.red,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black54,
          //isScrollable: true,
          tabs: <Widget>[
            Tab(

              text: "Contract Details",
            ),
            Tab(
              text: "Products",
            ),
            Tab(
              text: "History",
            ),

          ],
        ),
        SizedBox(height: 5.0,),
        Expanded(
          flex: 1,
          child: _currentData!=null ? Container(
            height: screenHeight * 0.75,
            margin: EdgeInsets.only(left: 5.0, right: 5.0,bottom: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TabBarView(
              controller: _nestedTabController,
              children: [ContractDetails(contract_data: _currentData.details,customer_id: _customer_id,status: _current_contract.status,),ContractProducts(contract_products: _currentData.products,),ContractHistory(contract_history:_currentData.history ,)]
            ),
          ) :Text("noData"),
        ),
      ],

    );
  }




  showAlertDialog(BuildContext context,switch_value) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop(); // dismiss dialog

      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {
        setState(() {
          //isSwitched=switch_value;
          _submitChanges(context,"Change Contract Status from "+_current_contract.status+" to "+(_current_contract.status=="Active"?"Deactive":"Active"));
          //Navigator.of(context).pop();
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Would you like to "+(_current_contract.status=="Active"?"Deactivate":"Activate")+" this Contract?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _submitChanges (BuildContext context,String bodyRequest)async{
    var response = await  http.post("http://gdms.nodust-eg.com:80/cmobile_API/ActiveDeactiveContract",headers: {'CUSTOMERID':_customer_id,'REQUESTBODY':bodyRequest,'CARDID':_current_contract.card_no});
    if(response.statusCode == 200) {
      CardResponse jsonResponse = CardResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="Done") {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: jsonResponse.message ??  "new Contract",
          toastLength: Toast.LENGTH_LONG,
        );

      }

    }

  }


  void loadCardData () async
  {
    var response = await  http.post("http://gdms.nodust-eg.com:80/cmobile_API/CardDetails",headers: {'CARDID':_current_contract.card_no});
    if(response.statusCode == 200) {
      print(response.body);
      CardDataResponse jsonResponse = CardDataResponse.fromJson(jsonDecode(response.body));
      print("CardDattttt"+jsonResponse.state);
      if(jsonResponse.state=="Success") {
        setState(() {
          _currentData =jsonResponse.data;
          if(_current_contract.status=="Active")
            isSwitched = true;
          else
            isSwitched = false;

        });

      }

    }

  }
}