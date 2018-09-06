import 'dart:async';
import 'dart:io';

import 'auth/SecretLoader.dart';
import 'auth/Secret.dart';

import 'package:draw/draw.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class RedditHelper {
  StreamSubscription<String> _onUrlChanged;

  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/cred.json');
  }

  Future<Secret> get _secrets async {
    Secret secrets =
        await SecretLoader(secretPath: "assets/secrets.json").load();
    return secrets;
  }

  writeCredentials(String credentials) async {
    final file = await _localFile;
    file.writeAsString(credentials);
  }

  Future<String> readCredentials() async {
    File file = await _localFile;
    if (FileSystemEntity.typeSync(file.path) == FileSystemEntityType.notFound) {
      return "";
    } else {
      try {
        final file = await _localFile;
        String creds = await file.readAsString();
        return creds;
      } catch (e) {
        return "";
      }
    }
  }

  Future<Reddit> login() async {
    final secret = await _secrets;
    FlutterWebviewPlugin fwp = FlutterWebviewPlugin();
    Reddit redditReturn;
    _onUrlChanged = fwp.onUrlChanged.listen((url) async {
      if (url.contains("state=ditra&code=")) {
        print("The troll toll has been paid");
        final secret = await _secrets;
        final reddit = Reddit.createWebFlowInstance(
          userAgent: "ditra",
          clientId: secret.clientId,
          clientSecret: secret.clientSecret,
          redirectUri: Uri.parse(secret.redirectUri),
        );
        String accessCode = Uri.parse(url).queryParameters["code"];
        final WebAuthenticator auth = reddit.auth;
        auth.url(['*'], 'ditra');
        await auth.authorize(accessCode);
        await writeCredentials(auth.credentials.toJson());
        fwp.close();
        redditReturn = reddit;
      }
    });
    await fwp.launch(secret.oauthUrl);
    return redditReturn;
  }

  Future<Reddit> getAnonClient({Secret secret}) async {
    if (secret == null) secret = await _secrets;
    Reddit anon = await Reddit.createReadOnlyInstance(
      clientId: secret.clientId,
      clientSecret: secret.clientSecret,
      userAgent: "ditra:plays2:v0.0 (anon)",
    );
    return anon;
  }

  Future<Reddit> getRedditClient() async {
    final secret = await _secrets;
    var credentials = await readCredentials();
    if (credentials == "" || credentials == null) {
      print("Getting unauthorized client...");
      Reddit client = await getAnonClient();
      return client;
    } else {
      Reddit client = await Reddit.restoreAuthenticatedInstance(
        credentials,
        clientId: secret.clientId,
        clientSecret: secret.clientSecret,
        userAgent: secret.userAgent,
      );
      return client;
    }
  }
}
