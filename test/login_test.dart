import 'dart:io';
import 'dart:convert';

import 'package:test/test.dart';
import 'package:draw/draw.dart';

import '../lib/network/main.dart';
import '../lib/network/auth/Secret.dart';

void main() async {
  Secret secret;
  /**
   * Make sure our secretloader works
   * 
   */
  test('SecretLoader loads secret', () {
    File('../assets/secrets.json')
    .readAsString()
    .then((fileContents) => json.decode(fileContents))
    .then((jsonData) {
      secret = Secret(
        clientId: jsonData["client_id"], 
        clientSecret: jsonData["client_secret"],
        userAgent: jsonData["user_agent"]
      );
      expect(true, 
        (secret.clientId != "" && secret.clientId != null
        && secret.clientId != "[secure]")
      );
      /**
       * Get an anonymous reddit client and check if it's 
       * valid. 
       */
      test('Get unauthorized reddit client', () async {    
        RedditHelper helper = RedditHelper();
        Reddit reddit = await helper.getAnonClient(secret: secret);
        var valid = reddit.auth.isValid;
        expect(true, valid);
      });
    });
  });
}