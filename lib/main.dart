import 'network/main.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:flutter/material.dart';

void main() => runApp(DitRa());
const OAUTH_URL = "";

class DitRa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => const DitRaHome(title: 'DitRa'),
      },
    );
  }
}

class DitRaHome extends StatefulWidget {
  const DitRaHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _DitRaHomeState();
}

class _DitRaHomeState extends State<DitRaHome> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();
    StreamSubscription<String>_onStateChanged = 
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        if (url.contains("?state=ditra&code=")) {
          var code = Uri.parse(url).queryParameters["code"].toString();
          flutterWebViewPlugin.close();
        }
      }
    });

  }
  
  

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('DitRa'),
        ),
        body: Container(
          child: Center(
            child: RaisedButton(
              child: Text('Login'),
              onPressed: () {
                flutterWebViewPlugin.launch(
                  OAUTH_URL                  
                );
              }
              
            ),
          ),
        ),
      );
    }
}