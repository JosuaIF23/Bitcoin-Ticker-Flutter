import 'dart:convert';
import 'package:http/http.dart';
import 'coin_data.dart';

const apiKey = 'fd3e7d383b4d4a3b91389605448843d5';
const url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest';

class NetworkHelper {
  Future getData(String selectedCurrency) async {
    String requestedUrl = '$url?symbol=BTC&convert=$selectedCurrency';

    Response response = await get(
      Uri.parse(requestedUrl),
      headers: {'X-CMC_PRO_API_KEY': apiKey, 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice =
          decodedData['data']['BTC']['quote'][selectedCurrency]['price'];

      return lastPrice;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
