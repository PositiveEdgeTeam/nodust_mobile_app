import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
class ViewProducts extends StatefulWidget {
  final myurl = "http://192.168.1.10/webPages/index.html";
  const ViewProducts({Key key}) : super(key: key);
  @override
  _ViewProductsState createState() => _ViewProductsState(this.myurl,this.key);
}

class _ViewProductsState extends State<ViewProducts> {
  var _url;
  final _key ;//= UniqueKey();
  _ViewProductsState(this._url,this._key);
  //final Completer<WebViewController>_controller =
 // Completer<WebViewController>();

  var uri;

  @override
  Widget build(BuildContext context) {
    return  WebView(
          key: _key,
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
        ) ;
  }
}
