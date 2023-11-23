import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/token_model.dart';

final tokenControllerProvider =
    StateNotifierProvider<TokenController, TokenModel?>((ref) {
  return TokenController(const FlutterSecureStorage());
});

class TokenController extends StateNotifier<TokenModel?> {
  final FlutterSecureStorage _storage;

  TokenController(this._storage) : super(null);

  Future<void> fetchTokens() async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      final tokenType = await _storage.read(key: 'token_type');
      final scope = await _storage.read(key: 'scope');
      if (accessToken != null && tokenType != null && scope != null) {
        state = TokenModel(
            accessToken: accessToken, tokenType: tokenType, scope: scope);
      }
    } catch (e) {
      state = null;
    }
  }

  Future<void> storeTokens(TokenModel tokenModel) async {
    await _storage.write(key: 'access_token', value: tokenModel.accessToken);
    await _storage.write(key: 'token_type', value: tokenModel.tokenType);
    await _storage.write(key: 'scope', value: tokenModel.scope);
    state = tokenModel;
  }

  Future<void> clearTokens() async {
    await _storage.deleteAll();
    state = null;
  }
}
