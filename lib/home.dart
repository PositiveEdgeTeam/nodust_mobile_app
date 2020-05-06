import 'package:flutter/material.dart';
import 'package:nodustmobileapp/Models/sharedPref.dart';
import 'package:nodustmobileapp/Models/user.dart';
import 'login.dart';

class Home extends StatefulWidget {
  //final String title;
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
                      Text(userLoad != null ? userLoad.customer_balance : "0"),
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

    return  Column(
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
      );
  }

  loadSharedPrefs() async {
    try {
      print("in function");
      User user = User.fromJson(await sharedPref.read("user_data"));
      print(user.customer_name);
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
    print("home");
    super.initState();
    loadSharedPrefs();
  }


}




