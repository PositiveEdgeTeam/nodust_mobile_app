import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nodustmobileapp/Models/sharedPref.dart';
import 'package:nodustmobileapp/homemenues.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nodustmobileapp/register.dart';

import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/loginResponse.dart';
import 'Models/user.dart';

class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  String myurl ="http://192.168.1.6:80/cmobile_API/LogIn";
  final  usernameController = new TextEditingController();
  int _radioValue =1;
  final passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "User Name",
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
          checkInput();
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
            child: ListView(
              children: <Widget>[ Column(
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
                    height: 10.0,
                  ),Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: 1,
                        groupValue: _radioValue,
                        activeColor: Colors.blue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        'Personal',
                        style: new TextStyle(fontSize: 16.0),
                      ),

                      new Radio(
                        value: 2,
                        activeColor: Colors.blue,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),

                      new Text(
                        'Company',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),

                    ],
                  ),
                  Center(
                    child: Row(children: <Widget>[
                      Text("Not A Member?"),
                      FlatButton(onPressed: (){
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new Register();
                        }));
                        },
                       child: Text("Sign Up" ,style: TextStyle(decoration: TextDecoration.underline,),),
                        textColor: Colors.blue,
                      )

                    ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center)
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeMenu(title: ' No Dust')), (Route<dynamic> route) => false);
                    },
                    child: Text("Skip"),
                    textColor: Colors.blue,
                  ),
                ],
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      });
  }

  void checkInput()
  {
    if(usernameController.text.isNotEmpty&&passwordController.text.isNotEmpty)
      signIn();
    else{
      Fluttertoast.showToast(
        msg: "Please Insert Your Email & Password",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  signIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
   // print("sssss"+_radioValue.toString());
    var response = await  http.post(myurl,headers: {'USERNAME':usernameController.text,'PASSWORD': passwordController.text,'TYPE':_radioValue.toString()});
    if(response.statusCode == 200) {
      print(response.body);
      LoginResponse jsonResponse = LoginResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="ok") {
        setState(() {
          _isLoading = false;
        });
        SharedPref sharedPref = SharedPref();
        //List<User> accounts = jsonResponse.data;
        //print("length"+ accounts.length.toString());
        for(int i =0;i<jsonResponse.data.length;i++)
          {
            if(jsonResponse.data[i].selected=="1")
              sharedPref.save("user_data", jsonResponse.data[i]);
            else
              sharedPref.save("another_account", jsonResponse.data[i]);

          }

        //sharedPreferences.setString("customer_id", jsonResponse.data[0].customer_id);
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
        _isLoading = false;
      });
      print(response.body);
    }
  }

}



