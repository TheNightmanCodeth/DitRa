import 'dart:async';

import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'widgets/image_post_card_widget.dart';
import 'widgets/text_post_card_widget.dart';
import 'widgets/comment_widget.dart';

class CommentsView extends StatefulWidget {
  CommentsView(this.sub);

  final Submission sub;

  @override
  _CommentsViewState createState() => _CommentsViewState(sub);
}

class _CommentsViewState extends State<CommentsView> {
  _CommentsViewState(this.submission);

  Submission submission;

  @override
  initState() {
    super.initState();
  }

  Future<CommentForest> initComments() async {
    CommentForest comments = await submission.refreshComments();
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListView(
            children: <Widget>[
              Builder(builder: (c) {
                if (submission.isSelf) {
                  return TextPost(submission);
                } else {
                  return ImagePost(submission, submission.score);
                }
              }),
              Container(height: 16.0),
              FutureBuilder(
                  future: initComments(),
                  builder: (c, snapshot) {
                    if (snapshot.hasData) {
                      CommentForest comments = snapshot.data;
                      return Column(
                        children: List.generate(comments.length, 
                          (index) {
                            var thisComment = comments[index];
                            return CommentWidget(thisComment);
                          }
                        ),
                      );
                    } else {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      return Container(
                        height: 0.0,
                        width: 0.0,
                      );
                    } 
                  })
            ],
          ),
        ),
      ]),
    );
  }
}
