import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

import 'network/main.dart';
import 'views/widgets/image_post_card_widget.dart';
import 'views/widgets/text_post_card_widget.dart';

void main() => runApp(MaterialApp(
      title: "DitRa",
      home: DitRaHome(title: "DitRa"),
    ));

class DitRaHome extends StatefulWidget {
  const DitRaHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _DitRaHomeState(title);
}

class _DitRaHomeState extends State<DitRaHome> {
  _DitRaHomeState(this.title);
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  RedditHelper redditHelper = RedditHelper();
  Reddit reddit;
  SubredditRef sub;
  String title;
  StreamController<UserContent> streamController;
  List<UserContent> list = [];
  List<Subreddit> subs = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<Null> load({SubredditRef subr}) async {
    streamController = StreamController.broadcast();
    list.clear();

    streamController.stream.listen((post) {
      setState(() => list.add(post));
    });

    reddit = await redditHelper.getRedditClient();

    if (sub == null) {
      reddit.front.hot().pipe(streamController);
    } else if (subr != null) {
      print(subr.displayName);
      subr.hot().pipe(streamController);
    } else {
      print(sub.displayName);
      await sub.hot().pipe(streamController);
    }

    if ((!reddit.auth.userAgent.contains("anon")) && subs.isEmpty) {
      print("redo subs");
      subs = await reddit.user.subreddits().toList();
    }

    return null;
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    streamController?.close();
    streamController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Text("Hello"),
              ),
              Builder(
                builder: (context) {
                  if (reddit.auth.userAgent.contains("anon")) {
                    return ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text("Login"),
                        onTap: () async {
                          reddit = await redditHelper.login();
                          load();
                        });
                  } else {
                    return Container(width: 0.0, height: 0.0);
                  }
                },
              ),
              Builder(builder: (ctx) {
                if (subs.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: subs.length + 1,
                      itemBuilder: (context, index) {
                        Subreddit subreddit = subs[index];
                        if (index == 0) {
                          return ListTile(
                            leading: Icon(Icons.home),
                            title: Text("Frontpage"),
                            onTap: () {
                              list.clear();
                              sub = null;
                              streamController = StreamController.broadcast();
                              streamController.stream.listen((post) {
                                setState(() => list.add(post));
                              });
                              reddit.front.hot().pipe(streamController);
                              setState(() {
                                title = "Frontpage";
                              });
                            },
                          );
                        }
                        return ListTile(
                          leading: Icon(Icons.album),
                          title: Text(subreddit.displayName),
                          onTap: () {
                            list.clear();
                            sub = reddit.subreddit(subreddit.displayName);
                            streamController = StreamController.broadcast();
                            streamController.stream.listen((post) {
                              setState(() => list.add(post));
                            });
                            sub.hot().pipe(streamController);
                            setState(() {
                              title = subreddit.displayName;
                            });
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return Container(width: 0.0, height: 0.0);
                }
              }),
            ],
          ),
        ),
        body: Container(
            child: RefreshIndicator(
          onRefresh: () => load(),
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index >= list.length) {
                return null;
              }
              return Builder(
                builder: (context) {
                  Submission post = list[index];
                  if (!post.isSelf) {                    
                    return ImagePost(post, post.score);
                  } else {
                    return TextPost(post);
                  }
                },
              );
            },
          ),
        )));
  }
}