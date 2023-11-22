class TokenModel {
  final String accessToken;
  final String tokenType;
  final String scope;

  TokenModel({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      scope: json['scope'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'scope': scope,
    };
  }

  @override
  String toString() {
    final string =
        'TokenModel(accessToken: $accessToken, tokenType: $tokenType, '
        'scope: $scope)';
    return string;
  }
}
