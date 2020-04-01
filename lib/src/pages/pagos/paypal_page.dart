import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class PaypalPage extends StatefulWidget {
  final String initialUrl;
  PaypalPage(this.initialUrl);
  @override
  _PaypalPageState createState() => _PaypalPageState();
}

class _PaypalPageState extends State<PaypalPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    //scaffoldKey.currentState.dispose();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: WebView(
        initialUrl: widget.initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        }
      /* onPageFinished: (String value){
          if(value == ''){
            Navigator.pushNamed(context, 'pagado');
          }else{
            Navigator.pop(context);
          }
        },*/
      ),
    );
  }
}