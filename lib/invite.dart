import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nodustmobileapp/Models/sharedPref.dart';

import 'Models/user.dart';
import 'homemenues.dart';

//void main() => runApp(MyApp());

class Invite extends StatefulWidget {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {

  SharedPref sharedPref = SharedPref();
  User userLoad;
  User anotherccount;
  TextEditingController _controller= new TextEditingController();
//String ID= userLoad.customer_id.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Invite'),
        ),
      body:ListView(
        children: <Widget>[
          Center(

            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(
                    width: 900,
                    height:400 ,
                    child: Image.asset(
                      "images/1.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),



                  TextFormField(initialValue: userLoad.customer_id.toString() +'-'+ userLoad.customer_phone.toString()),


                  Container(
                      child: MaterialButton(onPressed: (){
                        FlutterOpenWhatsapp.sendSingleMessage( "" , userLoad.customer_id.toString() +'-'+ userLoad.customer_phone.toString());
                        // FlutterOpenWhatsapp.sendSingleMessage( "+2001061571669" , "hi");
                        //FlutterOpenWhatsapp.platformVersion;
                      },


                        child: Text('Invite Friends'),
                        color: Colors.red,
                      )

                  ),
                ],

              ),
            ),
          ),
        ],
      ),);


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

