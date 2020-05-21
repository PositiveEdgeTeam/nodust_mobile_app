import 'package:flutter/material.dart';
import 'package:nodustmobileapp/contactUs.dart';

class Contactpage extends StatefulWidget {
  @override
  _ContactpageState createState() => _ContactpageState();
}

class _ContactpageState extends State<Contactpage> {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: new AppBar(
        title: new Text("ContactUs"),
        centerTitle: true,
      ),
      body:const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
         child: ContactUs(),
        ),
      ),
    );

  }
}
