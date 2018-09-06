class Secret {
  final String clientId;
  final String clientSecret;
  final String redirectUri;
  final String oauthUrl;
  final String userAgent;

  Secret({
    this.clientId = "",
    this.clientSecret = "",
    this.redirectUri = "",
    this.oauthUrl = "",
    this.userAgent = "",
  });

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
      clientId: jsonMap["client_id"],
      clientSecret: jsonMap["client_secret"],
      redirectUri: jsonMap["redirect_uri"],
      oauthUrl: jsonMap["oauth_url"],
      userAgent: jsonMap["user_agent"],
    );
  }
}
