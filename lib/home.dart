import 'package:flutter/material.dart';
import 'package:nodustmobileapp/Models/sharedPref.dart';
import 'package:nodustmobileapp/Models/user.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import 'AboutUs.dart';
import 'ClaimYourPoints.dart';
import 'ContactUs.dart';
import 'Notifications.dart';
import 'login.dart';

class Home extends StatefulWidget {
  //final String title;
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPref sharedPref = SharedPref();
  User userLoad;
  @override
  Widget build(BuildContext context) {
    final userData_card =  Container(
      child: Card(
      child:Row(
        children: <Widget>[
          Container(
            child:Column(
              children: <Widget>[
                Text( userLoad != null ? userLoad.customer_name: "customer_name"
                  ,style: TextStyle(
                    fontWeight: FontWeight.bold ,
                    fontSize: 20,
                  ),
                ),
                Text( userLoad != null ? userLoad.customer_mobile: "customer_mobile"
                  ,style: TextStyle(
                    fontWeight: FontWeight.bold ,
                    fontSize: 15,
                  ),)
              ],
            ) ,
            margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
          ),
          Spacer(flex: 1, ),

          Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.credit_card,
                        size: 40.0,
                      ),
                      Text("My Credit",style:
                      TextStyle(
                          fontSize: 10
                      ),
                      ),
                      Text(userLoad != null ? userLoad.customer_credit: "0"),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                ),


                Column(
                  children: <Widget>[
                    Icon(
                      Icons.trending_up,
                      size: 40.0,
                    ),
                    Text("My Points" ,
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                    Text(userLoad != null ? userLoad.customer_points: "0"),
                  ],
                ),


              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ) ,
            margin: EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
          ),




        ],
      ),
    ) ,
    );

    final login_btn =   Container(
                  width: double.infinity,
                  child: Center(
                    child:FlatButton(
                      child: Text("Login Now",style: TextStyle(
                       fontSize: 25,
                      ),),
                      textColor: Colors.blue,
                      padding: EdgeInsets.all(15.0),
                      onPressed: (){
                    Navigator.of(context)
                        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new Login();
                      }));},
                    ) ,)
                  ,
                );

    var first_item = login_btn;
    if (userLoad != null)
      first_item = userData_card ;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.account_circle,
                  size: 40.0,
                ),
              )
          )
        ],
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(child: new Text(''),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("images/logo.jpg"),
                        fit: BoxFit.cover)
                ),
              ),

              new ListTile(
                title: new Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                title: new Text('About Us'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new AboutUs()));
                },
              ),

              new ListTile(
                title: new Text('Notifications'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new Notifications()));
                },
              ),

              //  new Divider(),
              new ListTile(
                title: new Text('Claim your points'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new ClaimYourPoints()));
                },
              ),
              new ListTile(
                title: new Text('Contact Us'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new ContactUs()));
                },
              ),
              new ListTile(
                title: new Text('Invite'),
                onTap: () {},
              ),
            ],
          )
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),

          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.credit_card),
            title: new Text('My Cards'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Products')
          )
        ],
      ),

      body: Column(
        children: <Widget>[
          first_item,

          Spacer(),

          SizedBox(
            height: 400.0,
            child: Image.asset(
              "images/logo.jpg",
              fit: BoxFit.contain,
            ),
          ),

        ],
      ),
    );
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
      print("in Execption");
    }
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }


}




