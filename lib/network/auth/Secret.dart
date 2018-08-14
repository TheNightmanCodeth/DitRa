class Secret {  
  final String client_id;
  final String client_secret;  
  final String redirect_uri;
  final String oauth_url;

  Secret({
    this.client_id = "",
    this.client_secret = "",
    this.redirect_uri = "",
    this.oauth_url = "",
  });

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
      client_id: jsonMap["client_id"],
      client_secret: jsonMap["client_secret"],
      redirect_uri: jsonMap["redirect_uri"],
      oauth_url: jsonMap["oauth_url"],
    );
  }
}