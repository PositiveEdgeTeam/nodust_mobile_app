import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nodustmobileapp/Models/loginResponse.dart';
import 'package:nodustmobileapp/Models/sharedPref.dart';
import 'package:nodustmobileapp/Models/user.dart';
import 'package:nodustmobileapp/Models/userDb.dart';
import 'package:nodustmobileapp/homemenues.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nodustmobileapp/Database/database';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Profile extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPref sharedPref = SharedPref();
  User userLoad;
  String myurl ="http://gdms.nodust-eg.com:80/cmobile_API/LogIn";
  final dbHelper = DBProvider.db;
  User anotherccount;
  List<UserDb> another_accounts;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Profile"),
        centerTitle: true,
      ),
      body: Container( padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 200.0,
              color: Colors.black26,
            ),
            Center(
                child: Column(
                  children: <Widget>[
                    new Text(userLoad != null ? userLoad.customer_name: "customer_name" ,
                      style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 20,
                    ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    new Text(userLoad != null ? userLoad.customer_mobile: "customer_mobile" ),
                    SizedBox(
                      height: 20.0,
                    ),
                    new Text(userLoad != null ? userLoad.customer_classification+" Account" : "customer_account",
                      style: TextStyle(
                      fontSize: 20,
                    ),),
                    SizedBox(
                      height: 10.0,
                    ),
                    new Text(userLoad.collection != null ? userLoad.collection: "collection" ),
                    SizedBox(
                      height: 10.0,
                    ),
                    new Text(userLoad != null ? "You Have "+userLoad.cards.toString()+" Contracts" : "customer_account",
                      style: TextStyle(
                        fontSize: 15,
                      ),),
                    SizedBox(
                      height: 20.0,
                    ),

                     Center(
                       child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(
                                  Icons.trending_up,
                                  size: 50,color: Colors.white,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 25),
                              ),
                              Text("My Points" ,
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              ),
                              Text(userLoad != null ? userLoad.customer_points: "0"),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(
                                  Icons.credit_card,
                                  size: 50,color: Colors.white,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 25),
                              ),
                              Text("My Credit",style:
                              TextStyle(
                                  fontSize: 15
                               ),
                              ),
                              Text(userLoad != null ? userLoad.customer_balance+"\$" : "0"),
                            ],
                          ),
                        ],
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center
                       ),

                     ),
                    SizedBox(
                      height: (another_accounts == null|| another_accounts.length==0) ? 45: 10,
                    ),
                    FlatButton(
                      onPressed:logOut
                      ,
                      child: Text("Log out" ,
                          style: TextStyle(
                        fontSize: 20,
                        )
                      ),
                      textColor: Colors.blue,
                    ),
                    (another_accounts == null|| another_accounts.length==0) ? SizedBox(
                      height:1,
                    ):FlatButton(
                      onPressed: (){_modalBottomSheetMenu(context);},
                      child: Text("Switch Account" ,
                          style: TextStyle(
                            fontSize: 20,
                          )
                      ),
                      textColor: Colors.blue,
                    )

                  ],

                )

            )
          ],
        ),
      ),
    );
  }

  signIn(UserDb user) async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = status.subscriptionStatus.userId;
    var response = await  http.post(myurl,headers: {'USERNAME':user.username,'PASSWORD': user.password,'TOKEN':playerId,'TYPE':user.classification});
    if(response.statusCode == 200) {
      print(response.body);
      LoginResponse jsonResponse = LoginResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="ok") {

        SharedPref sharedPref = SharedPref();
        for(int i =0;i<jsonResponse.data.length;i++)
        {
          if(jsonResponse.data[i].selected=="1") {
            sharedPref.save("user_data", jsonResponse.data[i]);
          }
          else
            sharedPref.save("another_account", jsonResponse.data[i]);

        }
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeMenu(title: ' No Dust')), (Route<dynamic> route) => false);
      }
      else{
        print(jsonResponse.message);
        Fluttertoast.showToast(
          msg: jsonResponse.message ??  "Incorrect Email or Password",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
    else {
      setState(() {
      });
      print(response.body);
    }
  }

  logOut () async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeMenu(title: ' No Dust')), (Route<dynamic> route) => false);

  }
  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      print("in function");
      User user = User.fromJson(await sharedPref.read("user_data"));
      setState(() {
        userLoad = user;
      });
    } catch (Excepetion) {
      // do something
      print("in Execption 1");

    }
    int  count = await dbHelper.getUsersCount();
    print("count"+count.toString());
    if(count>1)
      {
        List<UserDb> accounts= await  dbHelper.getAllUsers(int.parse(userLoad.customer_id));
        for(int i=0 ; i<accounts.length;i++)
          {
            print("accounts"+accounts[i].username+accounts[i].password);
          }
        setState(() {
          another_accounts=accounts;
        });
      }

    /*

    try {
      User user = User.fromJson(await sharedPref.read("another_account"));
      setState(() {
        anotherccount = user;
      });
    } catch (Excepetion) {
      // do something
      print("in Execption 2");
    }

     */

  }
  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
        backgroundColor: Colors.white,
        isScrollControlled: true, // Important: Makes content maxHeight = full device height
        context: context,
        builder: (context) {
          return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                    new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:another_accounts.length,
                      itemBuilder: (context, i) {
                        return new ListTile(
                          title: new Text(
                            another_accounts[i].username,
                            style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                          trailing: IconButton(icon: Icon(Icons.delete),onPressed: (){
                            dbHelper.deleteUser(another_accounts[i].username);
                            setState(() {
                              another_accounts.removeAt(i);
                            });
                            Navigator.pop(context);
                          },),
                         onTap: (){
                            print(another_accounts[i].username);
                            signIn(another_accounts[i]);
                         },
                        );

                      }
                    ),
                    ],
                  )));
        });
  }
}
