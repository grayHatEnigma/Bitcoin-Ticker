import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'USD',
  'EGP',
  'EUR',
  'GBP',
  'SAR',
  'AED',
  'KWD'
];

const String btc = 'BTC';
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getPrice({String caller, @required String currency}) async {
    print('debugging: new http request from $caller - start');
    String url = 'https://api.coindesk.com/v1/bpi/currentprice/$currency.json';
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['bpi'][currency]['rate_float'];
      }
    } catch (error) {
      print('error has occured while fetching the data code: $error');
      return 0;
    }
  }
}
