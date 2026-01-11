import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'networking.dart';

const apiKey = 'fd3e7d383b4d4a3b91389605448843d5';
const url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  double? bitcoinPrice;
  bool isLoading = true;

  Future<void> getBitcoinExchangeRate() async {
    setState(() {
      isLoading = true;
    });

    NetworkHelper networkHelper = NetworkHelper(
      url: '$url?symbol=BTC&convert=$selectedCurrency',
      apiKey: apiKey,
    );

    var currencyData = await networkHelper.getData();

    setState(() {
      if (currencyData != null &&
          currencyData['data'] != null &&
          currencyData['data']['BTC'] != null) {
        bitcoinPrice =
            currencyData['data']['BTC']['quote'][selectedCurrency]['price'];
      }
      bitcoinPrice =
          currencyData['data']['BTC']['quote'][selectedCurrency]['price'];
      isLoading = false;
    });
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
    // TODO: implement initState
    super.initState();
    getBitcoinExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  isLoading
                      ? 'Wait a sec..We are getting There!!!'
                      : '1 BTC = ${bitcoinPrice!.toStringAsFixed(2)} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
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
