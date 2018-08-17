import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FlutterWebViewWidget extends StatelessWidget {
  FlutterWebViewWidget(this.url);
  final String url;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text("Webview"),
      ),
    );
  }
}