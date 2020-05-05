import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

//void main() => runApp(MyApp());

class Invite extends StatefulWidget {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Invite'),
        ),
        body: Center(
            child: MaterialButton(onPressed: (){
              FlutterOpenWhatsapp.sendSingleMessage("", "Hello");
            },
              child: Text('Invite '),
              color: Colors.red,
            )
        ),
      );

  }
}

