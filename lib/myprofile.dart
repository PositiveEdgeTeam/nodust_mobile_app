import 'package:flutter/material.dart';
import 'package:nodustmobileapp/Models/sharedPref.dart';
import 'package:nodustmobileapp/Models/user.dart';
import 'package:nodustmobileapp/homemenues.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPref sharedPref = SharedPref();
  User userLoad;
  User anotherccount;
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
                      height: 30.0,
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
                      height: anotherccount != null ? 10: 45,
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
                    anotherccount != null ? FlatButton(
                      onPressed: swapAccount,
                      child: Text("Switch Account" ,
                          style: TextStyle(
                            fontSize: 20,
                          )
                      ),
                      textColor: Colors.blue,
                    ):
                    SizedBox(
                      height:1,
                    ),
                  ],

                )

            )
          ],
        ),
      ),
    );
  }

  swapAccount () async
  {
    sharedPref.save("user_data", anotherccount.toJson());
    sharedPref.save("another_account",userLoad.toJson());
    setState(() {
      User swap = userLoad;
      userLoad = anotherccount;
      anotherccount = swap;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeMenu(title: ' No Dust')), (Route<dynamic> route) => false);

    });

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

    try {
      User user = User.fromJson(await sharedPref.read("another_account"));
      setState(() {
        anotherccount = user;
      });
    } catch (Excepetion) {
      // do something
      print("in Execption 2");
    }

  }
}
