import 'package:flutter/material.dart';
import 'package:nodustmobileapp/AboutUs.dart';
import 'package:nodustmobileapp/ClaimYourPoints.dart';
import 'package:nodustmobileapp/ContactUs.dart';
import 'package:nodustmobileapp/Notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:nodustmobileapp/login.dart';

import 'home.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Widget _defaultHome = new Home(title: ' No Dust');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //String userName = prefs.get("customer_id") ?? "_";
  var id_ = prefs.get("customer_id");
  if(id_== null)
    _defaultHome = new Login();
    //MyHomePage(title: ' No Dust'),

  runApp(new MaterialApp(
    title: 'NoDust',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: _defaultHome,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoDust',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
     // home: MyHomePage(),
    );
  }

}

