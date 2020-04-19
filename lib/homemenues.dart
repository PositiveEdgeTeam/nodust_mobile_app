import 'package:flutter/material.dart';
import 'package:nodustmobileapp/Models/user.dart';
import 'package:nodustmobileapp/home.dart';
import 'package:nodustmobileapp/mycards.dart';
import 'package:nodustmobileapp/viewProducts.dart';

import 'AboutUs.dart';
import 'ClaimYourPoints.dart';
import 'ContactUs.dart';
import 'Models/sharedPref.dart';
import 'Notifications.dart';
import 'login.dart';

class HomeMenu extends StatefulWidget {
  HomeMenu({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  User userLoad;
  int _currentIndex = 0;
  SharedPref sharedPref = SharedPref();
  List<Widget> _children = List<Widget>();/* = [ViewProducts( key: PageStorageKey('Page1'),)
    ,AboutUs( key: PageStorageKey('Page2'))
    ,Notifications()];*/
  final PageStorageBucket bucket = PageStorageBucket();


  @override
  void initState() {
    _children.add(Home());
    _children.add(MyCards());
    _children.add(ViewProducts( key: PageStorageKey('Page1')));
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {


    Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
      onTap: (int index) => setState(() => _currentIndex = index),
      currentIndex: selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon:  Icon(Icons.home), title:  Text('Home'),),
        BottomNavigationBarItem(
          icon:  Icon(Icons.credit_card), title:  Text('My Cards'),),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text('Products'),),
      ],
    );


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
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new ContactUs()));
            },
            ),
            new ListTile(
              leading: Icon(Icons.person_add)         ,
              title: new Text('Invite'),
              onTap: () {},
          ),
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

}
