import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:test/test.dart';
import 'package:draw/draw.dart';

import '../lib/network/main.dart';
import '../lib/network/auth/Secret.dart';

void main() async {

  /**
   * Parse the json file since we can't access assets
   * from within the test environment. The data will
   * be added in Travis using secure environment vars
   * but if you're running these tests locally you'll
   * need to get your own API access keys.
   */
<<<<<<< HEAD
  await File('../assets/secrets.json')
=======
  File('../assets/secrets.json')
>>>>>>> 7dc1f5804b29f2106c5cf618f99463fdbed9f420
    .readAsString()
    .then((fileContents) => json.decode(fileContents))
    .then((jsonData) {
      Secret secret = Secret(
        clientId: jsonData["client_id"], 
        clientSecret: jsonData["client_secret"],
        userAgent: jsonData["user_agent"]
      );
<<<<<<< HEAD

      /**
       * Make sure we can access the Reddit API without having a 
       * user signed in. 
       */
      test('Get unauthorized reddit client', () async {    
        RedditHelper helper = RedditHelper();
        Reddit reddit = await helper.getAnonClient(secret: secret);
        expect(true, reddit.auth.isValid);
      });

      /**
       * Make sure we can use the anonclient to load the frontpage.
       * Here we simply await a list of usercontent and make sure
       * it's not empty.
       */
      test('Get the frontpage', () async {
        RedditHelper helper = RedditHelper();
        Reddit reddit = await helper.getAnonClient(secret: secret);
        List<UserContent> frontpage = await reddit.front.hot().toList();
        expect(true, frontpage.isNotEmpty);
      });

      /**
       * Ensure we can access the comments on a Submission.
       */
      test('Get comments', () async {
        RedditHelper helper = RedditHelper();
        Reddit reddit = await helper.getAnonClient(secret: secret);
        UserContent uc = await reddit.front.hot().first;
        Submission submission = uc;
        await submission.refreshComments();
        expect(true, submission.comments != null);
        expect(true, submission.comments.length != 0);
      });
    });
}
=======
      runTests(secret);  
  });
}

void runTests(Secret secret) { 
  /**
   * Make sure we can access the Reddit API without having a 
   * user signed in. 
   */
  test('Get unauthorized reddit client', () async {    
    RedditHelper helper = RedditHelper();
    Reddit reddit = await helper.getAnonClient(secret: secret);
    expect(true, reddit.auth.isValid);
  });

  /**
   * Make sure we can use the anonclient to load the frontpage.
   * Here we simply await a list of usercontent and make sure
   * it's not empty.
   */
  test('Get the frontpage', () async {
    RedditHelper helper = RedditHelper();
    Reddit reddit = await helper.getAnonClient(secret: secret);
    List<UserContent> frontpage = await reddit.front.hot().toList();
    expect(true, frontpage.isNotEmpty);
  });

  /**
   * Ensure we can access the comments on a Submission.
   */
  test('Get comments', () async {
    RedditHelper helper = RedditHelper();
    Reddit reddit = await helper.getAnonClient(secret: secret);
    UserContent uc = await reddit.front.hot().first;
    Submission submission = uc;
    await submission.refreshComments();
    expect(true, submission.comments != null);
    expect(true, submission.comments.length != 0);
  });
}
>>>>>>> 7dc1f5804b29f2106c5cf618f99463fdbed9f420
