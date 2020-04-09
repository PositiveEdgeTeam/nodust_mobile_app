import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import 'AboutUs.dart';
import 'ClaimYourPoints.dart';
import 'ContactUs.dart';
import 'Notifications.dart';

class Home extends StatefulWidget {
  //final String title;
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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

      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "images/logo.jpg",
                    fit: BoxFit.contain,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  }




