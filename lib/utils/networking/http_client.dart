import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class AbstractHttpClient {
  Future<dynamic> post(String url, dynamic body) async {}
  Future<dynamic> get(String url) async {}
  Future<bool> delete(String url) async => false;
  Future<dynamic> update(String url, Map<String, dynamic> body) async {}
}

class HttpClient implements AbstractHttpClient {
  static HttpClient? _instance;

  HttpClient._internal();

  factory HttpClient() {
    if (_instance == null) {
      _instance = HttpClient._internal();
    }

    return _instance as HttpClient;
  }

  final Map<String, String> _headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  void setHeader(String key, String value) {
    if (!_headers.containsKey(key)) {
      _headers[key] = value;
    }
  }

  @override
  Future<dynamic> post(String url, dynamic body) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(body), headers: _headers);
      if (response.statusCode == 201) {
        return compute(jsonDecode, response.body);
      } else {
        throw Error();
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<dynamic> get(String url) async {
    try {
      var response = await http.get(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        return compute(jsonDecode, response.body);
      } else {
        // return result;
        throw Error();
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(String url) async {
    try {
      var response = await http.delete(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<dynamic> update(String url, Map<String, dynamic> body) async {
    try {
      var response = await http.patch(Uri.parse(url),
          headers: _headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        return compute(jsonDecode, response.body);
      } else {
        throw Error();
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}

HttpClient appClient = HttpClient();
