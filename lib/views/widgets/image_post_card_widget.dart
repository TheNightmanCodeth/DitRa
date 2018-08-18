

import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

import 'flutter_webview_widget.dart';

class ImagePost extends StatefulWidget {

  ImagePost(this.post);

  final Submission post;

  @override
  _ImagePostState createState() => _ImagePostState(post);
}

class _ImagePostState extends State<ImagePost> {

  _ImagePostState(this.post);
  Submission post;

  @override
  Widget build(BuildContext context) { 
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(post.title),
              subtitle: Text("${post.author} - ${post.subreddit.displayName}"),
            ),
            Image.network(post.url.toString())
          ],
        ),
      ),
    );
  }
}