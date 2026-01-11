import 'package:flutter/material.dart';
import 'coin_data.dart';

const apiKey = 'fd3e7d383b4d4a3b91389605448843d5';
const url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  Map<String, String> coinValues = {};
  bool isLoading = true;

  void getBitcoinExchangeRate() async {
    isLoading = true;
    try {
      var currencyData = await CoinData().getData(selectedCurrency);
      isLoading = false;
      setState(() {
        coinValues = currencyData;
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(value: currency, child: Text(currency));
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
        getBitcoinExchangeRate();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getBitcoinExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CryptoCard(
                  cryptoCurrency: 'BTC',
                  value: isLoading ? '?' : (coinValues['BTC'] ?? '?'),
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'BTC',
                  value: isLoading ? '?' : (coinValues['ETH'] ?? '?'),
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'BTC',
                  value: isLoading ? '?' : (coinValues['LTC'] ?? '?'),
                  selectedCurrency: selectedCurrency,
                ),
              ],
            ),
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDropdownButton(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,

    required this.selectedCurrency,
    required this.cryptoCurrency,
    required this.value,
  });

  final String selectedCurrency;
  final String cryptoCurrency;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 60),
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
        child: Text(
          '1 $cryptoCurrency = $value $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }
}
