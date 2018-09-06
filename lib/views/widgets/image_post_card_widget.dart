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
  bool upvoted, downvoted = false;
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
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text(post.title),
                subtitle:
                    Text("${post.author} - ${post.subreddit.displayName}"),
                trailing: Text(score.toString()),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ImageView(post.url.toString())))),
            Builder(
              builder: (ctx) {
                if (post.preview != null && post.preview.isNotEmpty) {
                  if (post.preview[0].source.url
                      .toString()
                      .contains(RegExp(r'(gif\b)|(png)|(jpg)'))) {
                    String url = "";
                    if (post.preview[0].source.url
                        .toString()
                        .contains("redditmedia")) {
                      url = post.preview[0].source.url
                          .toString()
                          .replaceAll("amp;", "");
                    } else
                      url = post.preview[0].source.url.toString();
                    return InkWell(
                      child: Container(
                        child: Image(
                          image: NetworkImage(url),
                          fit: BoxFit.fitWidth,
                          width: 500.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ImageView(post.url.toString())));
                      },
                    );
                  } else
                    return Container(width: 0.0, height: 0.0);
                } else {
                  return Container(width: 0.0, height: 0.0);
                }
              },
            ),
            Container(
              height: 45.0,
              child: Row(
                // Upvote
                children: <Widget>[
                  InkWell(
                    child: Container(
                      child: Icon(Icons.arrow_upward, size: 18.0),
                      margin: EdgeInsets.all(10.0),
                    ),
                    onTap: () async {
                      await post.upvote();
                      setState(() {
                        if (!upvoted) {
                          score += 1;
                          upvoted = true;
                          downvoted = false;
                        } else if (!downvoted) {
                          score -= 1;
                          downvoted = true;
                          upvoted = false;
                        }
                      });
                    },
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Icon(Icons.arrow_downward, size: 18.0)
                    ),
                    onTap: () async {
                      if (!downvoted) {
                        await post.downvote();
                        setState(() {
                          score -= 1;
                          downvoted = true;
                          upvoted = false;
                        });
                      } else if (!upvoted) {
                        await post.upvote();
                        setState(() {
                          score += 1;
                          downvoted = false;
                          upvoted = true;
                        });
                      }
                    }),
                  InkWell(
                    radius: 20.0,
                    child: Container(
                      child: Icon(Icons.comment, size: 18.0),
                      margin: EdgeInsets.all(10.0),
                    ),
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => CommentsView(post)));
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
