import 'dart:async';

import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

import '../ImageView.dart';
import '../CommentsView.dart';

class ImagePost extends StatefulWidget {

  ImagePost(this.post, this.score);

  final Submission post;
  final score;

  @override
  _ImagePostState createState() => _ImagePostState(post, score);
}

class _ImagePostState extends State<ImagePost> {

  _ImagePostState(this.post, this.score);
  Submission post;
  int score;

  @override
  void initState() {
    super.initState();
    score = post.score;
  }

  @override
  Widget build(BuildContext context) { 
    return Card(      
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(post.title),
              subtitle: Text("${post.author} - ${post.subreddit.displayName}"),
              trailing: Text(score.toString()),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ImageView(post.url.toString())))
            ),
            Builder(
              builder: (ctx) {
                if (post.thumbnail.toString().contains(RegExp(r'(gif\b)|(png)|(jpg)'))) {
                  return InkWell(
                    child: Image(
                      image: NetworkImage(post.thumbnail.toString()),
                      fit: BoxFit.fitWidth,
                      width: 500.0,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ImageView(post.url.toString())));        
                    },
                  );
                } else {
                  return Container(width: 0.0, height: 0.0);
                }
              },
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => CommentsView(post))),
              child: Container(
                height: 45.0,                
                child: Row(
                  // Upvote
                  children: <Widget>[
                    Padding(
                      child: InkWell(
                        radius: 20.0,
                        child: Icon(Icons.arrow_upward, size: 18.0),
                        onTap: () async {
                          await post.upvote();                        
                          setState(() {
                            score = score + 1;
                          });
                        },
                      ), 
                      padding: EdgeInsets.all(10.0),                                       
                    ),                    
                  ],                    
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}