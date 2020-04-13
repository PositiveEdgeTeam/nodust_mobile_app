import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nodustmobileapp/Models/sharedPref.dart';
import 'package:nodustmobileapp/home.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/loginResponse.dart';

class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  String myurl ="http://192.168.1.6:80/busBeep_API/LogIn";
  final  usernameController = new TextEditingController();

  final passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: usernameController,
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: passwordController,
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.red,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (){
          signIn();
        }
        ,
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
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
                  height: 150.0,
                  child: Image.asset(
                    "images/logo.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 30.0),
                emailField,
                SizedBox(height: 10.0),
                passwordField,
                SizedBox(
                  height: 25.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Row(children: <Widget>[
                    Text("Not A Member?"),
                    FlatButton(onPressed: (){},
                    child: Text("Sign Up" ,style: TextStyle(decoration: TextDecoration.underline,),),
                      textColor: Colors.blue,
                    )

                  ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center)
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home(title: ' No Dust')), (Route<dynamic> route) => false);
                  },
                  child: Text("Skip"),
                  textColor: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  signIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    var response = await  http.get(myurl,headers: {'USERNAME':usernameController.text,'PASSWORD': passwordController.text});
    if(response.statusCode == 200) {
      LoginResponse jsonResponse = LoginResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="ok") {
        setState(() {
          _isLoading = false;
        });
        SharedPref sharedPref = SharedPref();
        sharedPref.save("user_data", jsonResponse.data);
        sharedPreferences.setString("customer_id", jsonResponse.data.customer_id);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home(title: ' No Dust')), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

}



