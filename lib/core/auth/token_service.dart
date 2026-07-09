import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static const _tokenKey = 'auth_token';

  static final TokenService _instance = TokenService._();
  static TokenService get instance => _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _token;

  TokenService._();

  String? get token => _token;

  Future<void> saveToken(String token) async {
    _token = token;
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> loadToken() async {
    _token = await _storage.read(key: _tokenKey);
  }

  Future<void> clearToken() async {
    _token = null;
    await _storage.delete(key: _tokenKey);
  }
}
