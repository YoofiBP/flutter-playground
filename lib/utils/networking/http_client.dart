import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final Map<String, String> _headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  void setHeader(String key, String value) {
    if (!_headers.containsKey(key)) {
      _headers[key] = value;
    }
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
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
