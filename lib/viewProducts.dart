import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
class ViewProducts extends StatelessWidget {
  final Completer<WebViewController>_controller =
  Completer<WebViewController>();
  var uri;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: WebView(

          initialUrl: "http://192.168.1.4/webPages/list_child.html",
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
        ) );
  }
}
