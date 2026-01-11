import 'dart:convert';
import 'package:http/http.dart';
import 'coin_data.dart';

const apiKey = 'fd3e7d383b4d4a3b91389605448843d5';
const url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest';

class NetworkHelper {
  NetworkHelper({required this.url, required this.apiKey});

  final String url;
  final String apiKey;

  Future getData() async {
    String requestedUrl = '$url?symbol=BTC&convert=';

    Response response = await get(
      Uri.parse(url),
      headers: {'X-CMC_PRO_API_KEY': apiKey, 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
