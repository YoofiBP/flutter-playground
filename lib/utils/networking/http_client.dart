import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient {
  Future<dynamic> getData(String url) async {
    try {
      var uri = Uri.parse(url);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Error();
      }
    } on Exception catch (e) {
      rethrow;
    }
  }
}
