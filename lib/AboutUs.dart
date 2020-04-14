import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

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
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 155.0,
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
                child:RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
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
                )
              /*RichText(
              text: TextSpan(
                text: aboutUsContent,
                style: DefaultTextStyle.of(context).style
              //  fontSize:12,
              ),
            )*/
      /* WebView(

              initialUrl: "http://www.nodust-eg.com/?pg=about",
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              javascriptMode: JavascriptMode.unrestricted,
            ) */
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



/*class AboutUs extends StatefulWidget {
  _AboutUs createState() => _AboutUs();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}

class _AboutUs extends State <AboutUs> {
  // This widget is the root of your application.

  bool _isLoading = false;
  String myurl ="http://192.168.1.11:80/busBeep_API/AboutUs";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About Us"),
      ),

      body: function()  ,
    );
  }
  function () async{
    http.get(myurl);
  }

}*/


