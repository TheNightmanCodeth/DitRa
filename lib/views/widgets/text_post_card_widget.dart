

import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

import 'flutter_webview_widget.dart';

class TextPost extends StatefulWidget {

  TextPost(this.post);

  final Submission post;

  @override
  _TextPostState createState() => _TextPostState(post);
}

class _TextPostState extends State<TextPost> {

  _TextPostState(this.post);
  Submission post;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(post.title),               
                subtitle: Text("${post.author} - ${post.subreddit.displayName}"), 
              ),
              Text(post.selftext),
            ],
          ),
        ),
      );
  }
}