

import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

import 'flutter_webview_widget.dart';

class PostView extends StatefulWidget {

  PostView(this.post);

  final Submission post;

  @override
  _PostViewState createState() => _PostViewState(post);
}

class _PostViewState extends State<PostView> {

  _PostViewState(this.post);
  Submission post;

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (post.body == null) {
      // If the body is null it's a link post
      if(post.url.toString().contains(".jpg")){
        body = DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(post.url.toString()),
            ),
          ),
        );
      } else {
        body = MaterialButton(
          child: Text(post.url.toString()),
          onPressed: () {
            Navigator.of(context).push(              
              MaterialPageRoute(builder: (context) => FlutterWebViewWidget(post.url.toString()))
            );
          }
        );
      }
    } else {
      body = Text(post.body);
    }    
    return Card(
        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(post.title),               
                subtitle: Text("${post.author} - ${post.subreddit.displayName}"), 
              ),
              body,
            ],
          ),
        ),
      );
  }
}