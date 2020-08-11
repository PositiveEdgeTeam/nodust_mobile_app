import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nodustmobileapp/Models/user.dart';
import 'package:nodustmobileapp/home.dart';
import 'package:nodustmobileapp/invite.dart';
import 'package:nodustmobileapp/mycards.dart';
import 'package:nodustmobileapp/myprofile.dart';
import 'package:nodustmobileapp/viewProducts.dart';
import 'package:nodustmobileapp/contactpage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nodustmobileapp/Database/database';
import 'AboutUs.dart';
import 'ClaimYourPoints.dart';
import 'dart:io';
import 'Models/sharedPref.dart';
import 'Notifications.dart';
import 'login.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


class HomeMenu extends StatefulWidget {
  HomeMenu({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  User userLoad;

  int _currentIndex = 0;
  String regiserd_user="";
  String _message = '';
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final dbHelper = DBProvider.db;
  SharedPref sharedPref = SharedPref();
  List<Widget> _children = List<Widget>();/* = [ViewProducts( key: PageStorageKey('Page1'),)
    ,AboutUs( key: PageStorageKey('Page2'))
    ,Notifications()];*/
  StreamSubscription iosSubscription;
  final PageStorageBucket bucket = PageStorageBucket();


  @override
  void initState() {
    _children.add(Home());
    _children.add(MyCards());
    _children.add(ViewProducts( key: PageStorageKey('Page1')));
    super.initState();
    loadSharedPrefs();
    initPlatformState();
    /*if (Platform.isIOS) {
      iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
    }*/
    //getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: _viewProfile,
                child: Icon(
                  Icons.account_circle,
                  size: 40.0,
                ),
              ))
        ],
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                child: new Text(''),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("images/logo.jpg"), fit: BoxFit.cover)),
              ),

              new ListTile(
                leading: Icon(Icons.home),
                title: new Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: Icon(Icons.supervisor_account),
                title: new Text('About Us'),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new AboutUs()));
                },
              ),

              new ListTile(
                leading: Icon(Icons.notifications),
                title: new Text('Notifications'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Notifications()));
                },
              ),

              //  new Divider(),
              new ListTile(
                leading: Icon(Icons.trending_up),
                title: new Text('Claim your points'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ClaimYourPoints()));
                },
              ),
              new ListTile(
                leading: Icon(Icons.call),
                title: new Text('Contact Us'),
                onTap: () {
                  if(userLoad!=null||regiserd_user!="")
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new Contactpage()));
                  else
                    Navigator.of(context)
                        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                      return new Login();
                    }));
                },
              ),
              new ListTile(
                leading: Icon(Icons.person_add),
                title: new Text('Invite'),
                onTap: () {
                  if(userLoad!=null)
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new Invite()));
                  else
                    Navigator.of(context)
                        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                      return new Login();
                    }));
                },
              )
            ],
          )),
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), title:  Text('Home'),
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.credit_card), title:  Text('My Cards'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text('Products'),
          )
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      //_bottomNavigationBar(_currentIndex),
      /*BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
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
              icon: Icon(Icons.shopping_cart), title: Text('Products'))
        ],
      ),*/
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      /*PageStorage(
          child: _children[_currentIndex],
          bucket: bucket,
        ),*/

    );
  }
  void _onItemTapped(int index) {
    // print(index);
    if(index==1&&userLoad ==null){
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Login();
      }));
    }
    else{
      setState(() {
        _currentIndex = index;
      });
    }
  }
  _viewProfile()
  {
    if(userLoad ==null)
    {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Login();
      }));
    }
    else{
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new Profile()));
    }
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
    try{
      String x =await sharedPref.read("registerd_user");
      print("xxxxx"+x);
      setState(() {
        regiserd_user=x;
      });
    }
    catch(Excepetion){

    }
  }
/*void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (message)  {
          print('on message $message');
          return;
         // setState(() => _message = message["notification"]["title"]);
        },
       onBackgroundMessage: myBackgroundMessageHandler,

        onResume: (message) async {
      print('on resume $message');
       return;
    }, onLaunch: ( message)  {
      print('on launch $message');
      return;
    });
  }*/


}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    print("uiuiui");
    Fluttertoast.showToast(
      msg: "Notificationsss",
      toastLength: Toast.LENGTH_LONG,
    );
    final dynamic data = message['data'];

  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print("uiuiui2");
    print(notification);
  }

  // Or do other work.
}
Future<void> initPlatformState() async {
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init(
      "7bb058d7-3828-4c88-b504-c7312026b18f",
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: false
      }
  );
  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);

  OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
    print("recieved");
    print(notification.payload.title +"&"+notification.payload.body );
    // will be called whenever a notification is received
  });
  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {

    // will be called whenever a notification is opened/button pressed.
  });
  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // will be called whenever the subscription changes
    //(ie. user gets registered with OneSignal and gets a user ID)
  });
  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
  });
}