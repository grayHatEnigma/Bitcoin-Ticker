import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  Future<dynamic> getPrice(
      {@required String crypto, @required String currency}) async {
    String url =
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/$crypto$currency';
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (error) {
      print('error has occured while fetching the data code: $error');
    }
  }
}
