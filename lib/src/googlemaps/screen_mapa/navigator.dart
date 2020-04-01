import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationRoute extends StatefulWidget {
  final String origin;
  final String destination;

  NavigationRoute({@required this.origin,@required this.destination});
  @override
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigationRoute> {
  final Completer<WebViewController> _webController = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigator'),
      ),
      body: WebView(
        initialUrl: 'https://www.google.com/maps/dir/?api=1&origin=${widget.origin}&destination=${widget.destination}&travelmode=bicycling&dir_action=navigate',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller){
          _webController.complete(controller);
        },
      ),
    );
  }
}