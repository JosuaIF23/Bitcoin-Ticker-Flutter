import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = 'fd3e7d383b4d4a3b91389605448843d5';
const url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest';

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
  'ZAR',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

class CoinData {
  Future<Map<String, String>> getData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestedUrl = '$url?symbol=$crypto&convert=$selectedCurrency';

      http.Response response = await http.get(
        Uri.parse(requestedUrl),
        headers: {'X-CMC_PRO_API_KEY': apiKey, 'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice =
            decodedData['data'][crypto]['quote'][selectedCurrency]['price'];

        cryptoPrices[crypto] = lastPrice.toStringAsFixed(2);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    }
    return cryptoPrices;
  }
}
