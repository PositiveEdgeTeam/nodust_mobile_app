import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nodustmobileapp/Models/cardsResponse.dart';
import 'package:nodustmobileapp/Models/sharedPref.dart';
import 'package:nodustmobileapp/carddata.dart';
import 'Models/contract.dart';
import 'Models/user.dart';

class MyCards extends StatefulWidget {
  @override
  _MyCardsState createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  String myurl ="http://192.168.1.6:80/cmobile_API/GetContracts";
  String newContractUrl = "http://192.168.1.6:80/cmobile_API/RequestContract";
  User userLoad;
  bool _agreedToTOS = false;
  SharedPref sharedPref = SharedPref();
  List<Contract> mycards = [];

  StreamSubscription<ConnectivityResult> subscription;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
              Container(
                child: Card(
                  child:Row(
                    children: <Widget>[
                        Container(
                          child:Text( "My Cards"
                            ,style: TextStyle(
                            fontWeight: FontWeight.bold ,
                            color: Colors.black54,
                            fontSize: 25,
                           ),
                          ) ,
                   margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 25),
                    ),
                    Spacer(flex: 1, ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.black54,
                            size: 40.0,
                          ),
                          onPressed: (){
                            if (_agreedToTOS)
                              addNewContract();
                            else
                              _showConnectLost();
                          },
                        ) ,
                        margin: EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
                      ),
              ],
              ),
              ) ,
              ),

              mycards!=null ?Expanded(flex: 1,
                 child: Container(
                  child: new ListView.builder
              (
                   itemCount: mycards.length,
                     itemBuilder: (BuildContext ctxt, int index) {
                   return  GestureDetector(
                     onTap: () {
                       Navigator.push(context,
                           new MaterialPageRoute(builder: (context) => new CardData(current_contract: mycards[index],customer_id: userLoad.customer_id,)));
                     },

                     child: Container(
                      child: Card(
                        child:Row(
                          children: <Widget>[
                            Icon(
                              Icons.assignment,
                              size: 50.0,
                              color: Colors.black26,
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              child: Column(children: <Widget>[
                                Row(children: <Widget>[
                                  Text("Contract No : ",style: TextStyle(
                                    fontWeight: FontWeight.bold ,
                                    fontSize: 15,
                                  ),
                                  ),
                                  Text( mycards[index].card_no
                                  )
                                  ,
                                ],
                                ),
                                Row(children: <Widget>[
                                  Text("Price : ",style: TextStyle(
                                  fontWeight: FontWeight.bold ,
                                  fontSize: 15,
                                  ),),
                                  Text( mycards[index].card_value+"EGP") ,

                                ],)
                              ],),

                              margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
                            ),
                            Spacer(flex: 1, ),
                            Container(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black26,
                                size: 40.0,
                              ) ,
                              margin: EdgeInsets.symmetric(horizontal: 10 ,vertical: 15),
                            ),


                          ],
                        ),
                      ) ,
                  ),
                   );
                }
            ),
          ),
        ) : Text("You don't have Contracts yet"),
      ],
    );
  }
  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    print("zzz");
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      if (result == ConnectivityResult.mobile ||result == ConnectivityResult.wifi) {
        loadCards();
        setState(() {
          _agreedToTOS = true;
        });
      }
      else{
        print("no internet");
        setState(() {
          _agreedToTOS = false;
        });
        _showConnectLost();

      }
    });

  }

  loadSharedPrefs() async {
    try {
      print("in function cards");
      User user = User.fromJson(await sharedPref.read("user_data"));
      print(user.customer_name);
      setState(() {
        userLoad = user;
      });
      _checkConnection();
     // print("connrctive"+_agreedToTOS.toString());
     // if(_agreedToTOS)
      //  loadCards();
    } catch (Excepetion) {
      // do something
      print("in Execption cards");
    }
  }

  void loadCards () async
  {
    var response = await  http.post(myurl,headers: {'CUSTOMERID':userLoad.customer_id});
    if(response.statusCode == 200) {
      print(response.body);
      CardResponse jsonResponse = CardResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="Success") {
        setState(() {
          mycards = jsonResponse.data;
        });

      }

    }

  }
  
  
  void addNewContract() async
  {
    var response = await  http.post(newContractUrl,headers: {'CUSTOMERID':userLoad.customer_id});
    if(response.statusCode == 200) {
      print(response.body);
      CardResponse jsonResponse = CardResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="Done") {
        Fluttertoast.showToast(
          msg: jsonResponse.message ??  "new Contract",
          toastLength: Toast.LENGTH_LONG,
        );

      }

    }
  }


  void _checkConnection()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        print("inside _connection");
        _agreedToTOS = true;
      });
      loadCards();
    } else  {
      print("no internet");
      setState(() {
        _agreedToTOS = false;
      });
      _showConnectLost();

    }
  }
  
  void _showConnectLost()
  {
    showDialog(
        context: context,
        builder: (_) => Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ), Center( // A simplified version of dialog.
                  child: Text('Connection Lost',
                    style: TextStyle(fontSize: 30,color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text('We were unable to complete your request. please try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15,color: Colors.white),
                    maxLines: 2,
                  ),
                ),
                Spacer(flex: 1, ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: RaisedButton(
                      child: Text('Ok' ,style: TextStyle(color: Colors.white,fontSize: 20),),
                      color: Colors.red,
                      onPressed: (){
                        Navigator.pop(_);
                      },
                      padding: EdgeInsets.symmetric(horizontal:10 ),

                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        )
    );
  }
}
