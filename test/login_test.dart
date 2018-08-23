import 'package:test/test.dart';
import 'package:draw/draw.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../lib/network/main.dart';

void main() async {
  
  



  /**
   * Make sure our secretloader works
   * 
   */
  test('SecretLoader loads secret', () {
    print(clientId);
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