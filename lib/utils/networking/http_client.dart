import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient {
  final Map<String, String> _headers = {};

  void setHeader(String key, String value) {
    if (!_headers.containsKey(key)) {
      _headers[key] = value;
    }
  }

  dynamic get(String url) async {
    try {
      var uri = Uri.parse(url);
      var response = await http.get(uri, headers: _headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
        // return result;
      } else {
        throw Error();
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<bool> delete(String url) async {
    try {
      var uri = Uri.parse(url);
      var response = await http.delete(uri, headers: _headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }
}

HttpClient appClient = HttpClient();
