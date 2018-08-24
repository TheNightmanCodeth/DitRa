import 'dart:io';
import 'dart:convert';

import 'package:test/test.dart';
import 'package:draw/draw.dart';

import '../lib/network/main.dart';

void main() async {
  /**
   * Make sure our secretloader works
   * 
   */
  test('SecretLoader loads secret', () {
    File('../assets/secrets.json')
    .readAsString()
    .then((fileContents) => json.decode(fileContents))
    .then((jsonData) {
      print(jsonData);
    });
  });

  /**
   * Get an anonymous reddit client and check if it's 
   * valid. 
   */
  test('Get unauthorized reddit client', () async {    
    RedditHelper helper = RedditHelper();
    Reddit reddit = await helper.getAnonClient();
    var valid = reddit.auth.isValid;
    expect(true, valid);
  });


}