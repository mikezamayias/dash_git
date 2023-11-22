import 'dart:convert';
import 'dart:developer';

import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

import '../controllers/token_controller.dart';
import '../env/env.dart';
import '../models/token_model.dart';

class GitHubAuth {
  static String clientId = Env.githubClientId;
  static String clientSecret = Env.githubClientSecret;
  static String redirectUri = 'dashgit://oauth2redirect';
  static String githubOAuthUrl = 'https://github.com/login/oauth/authorize';
  static const String githubTokenUrl =
      'https://github.com/login/oauth/access_token';

  Future<String> _getAuthorizationCode(List<String> scopes) async {
    final url = _getAuthUrlWithScopes(scopes);
    log(url, name: 'url');
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: 'dashgit',
      );
      log(result, name: 'result');
      final code = Uri.parse(result).queryParameters['code'];
      log('$code', name: 'code');
      return code ?? '';
    } catch (e) {
      throw Exception('Failed to get authorization code');
    }
  }

  Future<TokenModel> _exchangeCodeForAccessToken(String code) async {
    log(githubTokenUrl, name: '_exchangeCodeForAccessToken:githubTokenUrl');
    log(clientId, name: '_exchangeCodeForAccessToken:clientId');
    log(clientSecret, name: '_exchangeCodeForAccessToken:clientSecret');
    log(redirectUri, name: '_exchangeCodeForAccessToken:redirectUri');
    log(code, name: '_exchangeCodeForAccessToken:code');

    final response = await http.post(
      Uri.parse(githubTokenUrl),
      headers: {
        'Accept': 'application/json',
        'Content-Type':
            'application/x-www-form-urlencoded', // Include this header
      },
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': code,
        'redirect_uri': redirectUri,
      },
    );
    log(response.body, name: '_exchangeCodeForAccessToken:response.body');

    if (response.statusCode == 200) {
      final tokenData = json.decode(response.body);
      return TokenModel.fromJson(tokenData);
    } else {
      throw Exception(
          'Failed to exchange code for access token. Status code: ${response.statusCode}, Response: ${response.body}');
    }
  }

  Future<TokenModel> _refreshAccessToken(
      String refreshToken, List<String> scopes) async {
    final response = await http.post(
      Uri.parse(githubTokenUrl),
      body: {
        'grant_type': 'refresh_token',
        'client_id': clientId,
        'client_secret': clientSecret,
        'refresh_token': refreshToken,
        'scope': scopes.join(','),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to refresh access token');
    }

    // Parse the response body
    final tokenData = Uri.splitQueryString(response.body);
    return TokenModel.fromJson(tokenData);
  }

  Future<void> authenticate() async {
    final scopes = ['repo,gist,user,user:email,user:follow'];
    try {
      final code = await _getAuthorizationCode(scopes);
      final tokenModel = await _exchangeCodeForAccessToken(code);
      TokenController().storeTokens(tokenModel);
    } on Exception {
      rethrow;
    }
  }

  Future<void> refresh() async {
    TokenController tokenManager = TokenController();
    TokenModel tokens = await tokenManager.getTokens();
    String refreshToken = tokens.accessToken;
    List<String> scopes = tokens.scope.split(',');

    try {
      final tokenModel = await _refreshAccessToken(refreshToken, scopes);
      await tokenManager.storeTokens(tokenModel);
    } on Exception {
      rethrow;
    }
  }

  Future<void> revokeAccessToken(String accessToken) async {
    final response = await http.post(
      Uri.parse('https://api.github.com/applications/$clientId/token'),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $accessToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to revoke access token');
    }
  }

  Future<void> logout() async {
    TokenController tokenManager = TokenController();
    TokenModel tokens = await tokenManager.getTokens();
    String accessToken = tokens.accessToken;

    await revokeAccessToken(accessToken);
    await tokenManager.clearTokens();
  }

  String _getAuthUrlWithScopes(List<String> scopes) {
    final url = Uri.https('github.com', '/login/oauth/authorize', {
      'client_id': clientId,
      'response_type': 'code',
      'redirect_uri': redirectUri,
      'scope': scopes.join(','),
    });
    return url.toString();
  }
}
