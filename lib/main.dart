import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

import 'network/main.dart';
import 'network/auth/SecretLoader.dart';

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
  StreamSubscription<String>_onStateChanged;
  StreamSubscription _onDestroy;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    _onDestroy.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  Future<List<UserContent>> postList() async {
    reddit = await redditHelper.getRedditClient();
    print(reddit.readOnly.toString());
    return reddit.front.hot().toList();
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
          child: FutureBuilder(
            future: postList(),
            builder: (context, snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.waiting: return Text('Loading...');
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error.toString());
                    return Text('whoopsiee');
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Submission submission = snapshot.data[index];
                        return Card(
                          child: Text(submission.title),
                        );
                      },
                    );
                  }
              }
            },
          )
        ),
      );
    }
}