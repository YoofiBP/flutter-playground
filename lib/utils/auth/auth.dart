import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///Manages App Authentication
class AppAuth {
  static const String _AUTH0_DOMAIN = 'dev-zrgm1hwu.us.auth0.com';
  static const String _AUTH0_CLIENT_ID = 'E7HfkbRJu8x2ifiZRokPALXCeaBEi3xy';

  static const String _AUTH0_REDIRECT_URI =
      'com.auth0.flutterdemo://login-callback';
  static const String _AUTH0_ISSUER = 'https://$_AUTH0_DOMAIN';

  // final Function notifyAction;

  // AppAuth(this.notifyAction);

  bool isBusy = false;
  bool isLoggedIn = false;
  String _errorMessage = '';
  String _name = '';
  dynamic _picture;

  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  ///parse ID token
  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = 'https://$_AUTH0_DOMAIN/userInfo';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get User details');
    }
  }

  Future<void> loginAction(Function notifyAction) async {
    isBusy = true;
    _errorMessage = '';

    try {
      final result = await _appAuth.authorizeAndExchangeCode(
              AuthorizationTokenRequest(_AUTH0_CLIENT_ID, _AUTH0_REDIRECT_URI,
                  issuer: 'https://$_AUTH0_DOMAIN',
                  scopes: ['openid', 'profile', 'offline_access']))
          as AuthorizationTokenResponse;

      final idToken = parseIdToken(result.idToken as String);
      final profile = await getUserDetails(result.accessToken as String);

      await _secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);

      isBusy = false;
      isLoggedIn = true;
      _name = idToken['name'];
      _picture = profile['picture'];
      notifyAction();
    } on Exception catch (e, s) {
      print('login error: $e - stack: $s');

      isBusy = false;
      isLoggedIn = false;
      _errorMessage = e.toString();
    }
  }

  void logoutAction() async {
    await _secureStorage.delete(key: 'refresh_token');

    isLoggedIn = false;
    isBusy = false;
  }

  void initAction() async {
    final storedRefreshToken = await _secureStorage.read(key: 'refresh_token');

    if (storedRefreshToken == null) return;

    isBusy = true;

    try {
      final response = await _appAuth.token(TokenRequest(
          _AUTH0_DOMAIN, _AUTH0_REDIRECT_URI,
          refreshToken: storedRefreshToken,
          issuer: _AUTH0_ISSUER)) as TokenResponse;

      print('Init action run');
      print(response);

      final idToken = parseIdToken(response.idToken as String);
      final profile = await getUserDetails(response.accessToken as String);

      _secureStorage.write(key: 'refresh_token', value: response.refreshToken);

      isBusy = false;
      isLoggedIn = true;
      _name = idToken['name'];
      _picture = profile['picture'];
    } on Exception catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }
}
