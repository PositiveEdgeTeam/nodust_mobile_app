import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

String myurl ="http://gdms.nodust-eg.com:80/cmobile_API/AboutUs";

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}


class _AboutUsState extends State<AboutUs> {
//  final Completer<WebViewController>_controller =
//  Completer<WebViewController>();

  var uri;

  String aboutUsContent = "wait for connection";


  @override
  Widget build(BuildContext context) {
    //getAboutUs();
    return  Scaffold(
        appBar: AppBar(
          title: Text('About Us'),

        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        child: Image.asset(
                          "images/logo.jpg",
                          fit: BoxFit.contain,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
               child:Container(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 child: RichText(
                      text: TextSpan(
                       // style: DefaultTextStyle.of(context).style,

                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25.0,fontFamily: 'Cardo'  ),
                        children: <TextSpan>[
                          TextSpan(
                            text: aboutUsContent,


                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                                fontSize:15,


                                color:Colors.black12.withOpacity(1.0)
                            ),
                          ),
                        ],
                      ),
                    ),
               )

            ),
          ],
        ) );
  }

  @override
  void initState() {
// to call the page only when loading for first time and only one
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getAboutUs();

       });
        }

  void getAboutUs() async {
    var jsonResponse = null;
    var response = await  http.get(myurl);
    if(response.statusCode == 200) {
      Map jsonResponse = json.decode(response.body);
//print(bodyMap['customer_name'].toString());
        if(jsonResponse['state'].toString()=='Success') {
          Map jsonResponseContent= jsonResponse['data'];
          print(jsonResponseContent['NoDust']);
        setState(() {
          aboutUsContent=jsonResponseContent['NoDust'];
       //   _isLoading = false;
        });
     //   print(response.body);
     //   sharedPreferences.setString("customer_id", jsonResponse['customer_id']);
      //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), (Route<dynamic> route) => false);
      }
    }


  }
  }





