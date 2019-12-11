import 'package:bitcoin_ticker/services/network_helper.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  NetworkHelper networkHelper = NetworkHelper();

  Future<dynamic> getBTCPrice(String selectedCurrency) async {
    var btc =
        await networkHelper.getPrice(crypto: 'BTC', currency: selectedCurrency);

    return btc['averages']['day'];
  } // BTC

  Future<dynamic> getETHPrice(String selectedCurrency) async {
    var eth =
        await networkHelper.getPrice(crypto: 'ETH', currency: selectedCurrency);

    return eth['averages']['day'];
  } // ETH

  Future<dynamic> getLTCPrice(String selectedCurrency) async {
    var ltc =
        await networkHelper.getPrice(crypto: 'LTC', currency: selectedCurrency);

    return ltc['averages']['day'];
  } // LTC

}
