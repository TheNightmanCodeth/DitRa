import 'package:flutter/material.dart';
import 'widgets/flutter_webview_widget.dart';

class ImageView extends StatelessWidget {
  ImageView(this.url);

  String url;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) {
        if (url.contains(RegExp(r'(png)|(jpg)|(gif\b)'))) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black.withAlpha(10),
            ),
            body: Image.network(url),
          );
        } else {
          return FlutterWebViewWidget(url);
        }
      },
    );
  }
}
