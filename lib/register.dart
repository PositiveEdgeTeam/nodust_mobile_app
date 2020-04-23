import 'package:flutter/material.dart';
import 'package:nodustmobileapp/registerForm.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
        appBar: new AppBar(
         title: new Text("Register"),
       centerTitle: true,
      ),
        body:const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: RegisterForm(),
          ),
        ),
    );

  }
}
