import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  ImageView(this.url);

  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.black.withAlpha(10),
      ),
      body: Image.network(url),
    );
  }
}