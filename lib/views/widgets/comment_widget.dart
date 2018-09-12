import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CommentWidget extends StatefulWidget {
  CommentWidget(this.post, this.level);

  final dynamic post;
  final int level;

  @override
  _CommentWidgetState createState() => _CommentWidgetState(this.post, this.level);
}

class _CommentWidgetState extends State<CommentWidget> {
  _CommentWidgetState(this.post, this.level);

  dynamic post;
  int level;

  @override
  Widget build(BuildContext context) {
    if (post is MoreComments) {
      return InkWell(
        onTap: () {},
        child: Container(
          padding:
              EdgeInsets.only(left: 8.0 * this.level, top: 8.0, bottom: 8.0, right: 8.0),
          child: Text("More comments..."),
        ),
      );
    } else if (post is Comment) {
      return InkWell(
        //TODO (TheNightman): Implement actions extending
        onLongPress: () {},
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0 * this.level, right: 8.0),
                    child: Column(children: [
                      //The top row which contains the author, flair and score
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          //The post's author
                          Text(
                            post.author,
                            style: TextStyle(fontSize: 12.0),
                          ),
                          //The post's author's flair text
                          Builder(
                            builder: (ctx) {
                              if (post.authorFlairText != null) {
                                return Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      color: Colors.grey,
                                    ),
                                    child: Text(
                                      post.authorFlairText,
                                      style: TextStyle(
                                        fontSize: 8.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(width: 0.0, height: 0.0);
                              }
                            },
                          ),
                          //The score of the post
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                post.score.toString(),
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //The actual comment body
                      Container(
                          margin: EdgeInsets.only(top: 8.0),
                          alignment: Alignment.centerLeft,
                          child: MarkdownBody(
                            data: post.body,
                            styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                              textTheme: TextTheme(
                                body1: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: "Raleway",
                                ),
                              ),
                            )),
                          )),
                    ]),
                  ),
                ),
              ],
            ),
            //Item seperator
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.10,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }
}
