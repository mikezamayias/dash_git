import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/token_model.dart';

class TokenController {
  // Singleton
  static final TokenController _instance = TokenController._internal();
  factory TokenController() => _instance;
  TokenController._internal() : _storage = const FlutterSecureStorage();

  // Properties
  final FlutterSecureStorage _storage;
  TokenModel? tokenModel;
  final userIsLoggedInProvider = StateProvider<bool>((ref) => false);

  // Methods
  Future<TokenModel?> fetchTokens() async {
    TokenController tokenController = TokenController();
    try {
      tokenModel = await tokenController.getTokens();
    } on Exception {
      tokenModel = null;
    }
    return tokenModel;
  }

  Future<void> storeTokens(TokenModel tokenModel) async {
    await _storage.write(
      key: 'access_token',
      value: tokenModel.accessToken,
    );
    await _storage.write(
      key: 'token_type',
      value: tokenModel.tokenType,
    );
    await _storage.write(
      key: 'scope',
      value: tokenModel.scope,
    );
  }

  Future<TokenModel> getTokens() async {
    String? accessToken = await _storage.read(key: 'access_token');
    String? tokenType = await _storage.read(key: 'token_type');
    String? scope = await _storage.read(key: 'scope');

    log('$accessToken', name: 'accessToken');
    log('$tokenType', name: 'tokenType');
    log('$scope', name: 'scope');

    try {
      return TokenModel(
        accessToken: accessToken!,
        tokenType: tokenType!,
        scope: scope!,
      );
    } catch (e) {
      throw Exception('Incomplete token data');
    }
    // END: ed8c6549bwf9
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'token_type');
    await _storage.delete(key: 'scope');
  }
}
