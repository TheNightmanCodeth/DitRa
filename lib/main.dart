import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

import 'network/main.dart';
import 'views/widgets/image_post_card_widget.dart';
import 'views/widgets/text_post_card_widget.dart';

void main() => runApp(MaterialApp(
  title: "DitRa",
  home: DitRaHome(),
));


class DitRaHome extends StatefulWidget {
  const DitRaHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _DitRaHomeState();
}

class _DitRaHomeState extends State<DitRaHome> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  RedditHelper redditHelper = RedditHelper();
  Reddit reddit;

  StreamController<UserContent> streamController;
  List<UserContent> list = [];

  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((post) {
      setState(() => list.add(post));
    });

    load();
  }

  load() async {
    reddit = await redditHelper.getRedditClient();
    reddit.front.hot().pipe(streamController);
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    streamController?.close();
    streamController = null;
    super.dispose();
  }

  Future<void> postList() async {    
    
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('DitRa'),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Text("Hello"),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Login"),
                onTap: () async {
                  reddit = await redditHelper.login();
                }
              ),
            ],
          ),
        ),
        body: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index >= list.length) {
                return null;
              }
              return Builder(
                builder: (context) {
                  Submission post = list[index];
                  if (!post.isSelf) {
                    return ImagePost(post);
                  } else {
                    return TextPost(post);
                  }
                },
                
              );
            },
          )
        )
      );      
    }
}