import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../networking/http_client.dart';
import '../state_management/redux/actions/actions.dart';
import '../state_management/redux/reducers/app_state_reducer.dart';

///Manages App Authentication
class AppAuth extends ChangeNotifier {
  static const String _AUTH0_DOMAIN = 'dev-zrgm1hwu.us.auth0.com';
  static const String _AUTH0_CLIENT_ID = 'E7HfkbRJu8x2ifiZRokPALXCeaBEi3xy';

  static const String _AUTH0_REDIRECT_URI =
      'com.auth0.flutterdemo://login-callback';
  static const String _AUTH0_ISSUER = 'https://$_AUTH0_DOMAIN';

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

  Future<Map<String, String>> loginAction() async {
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

      appClient.setHeader('Authorization', 'Bearer auth');

      return {'username': idToken['name'], 'picture': profile['picture']};
    } on Exception catch (e, s) {
      print('login error: $e - stack: $s');
      rethrow;
    }
  }

  void logoutAction() async {
    await _secureStorage.delete(key: 'refresh_token');

    store.dispatch(SetLoggedIn(isLoggedIn: false));
    store.dispatch(SetIsBusy(isBusy: false));
    store.dispatch(NavigationAction(route: '/'));
  }

  void initAction() async {
    final storedRefreshToken = await _secureStorage.read(key: 'refresh_token');

    print(storedRefreshToken);

    if (storedRefreshToken == null) return;

    store.dispatch(SetIsBusy(isBusy: true));

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

      store.dispatch(SetIsBusy(isBusy: false));
      store.dispatch(SetLoggedIn(isLoggedIn: true));

      store.dispatch(
          SetUserInfo(username: idToken['name'], picture: profile['picture']));
    } on Exception catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }
}
