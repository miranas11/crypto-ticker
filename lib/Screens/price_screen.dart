import 'package:bitcoin_ticker/Utilities/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../services/exchange.dart';
import '../Utilities/ResusableCard.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String crypto = 'BTC';
  String selectedCurrency = 'AUD';
  List<double> convertedData = [0, 0, 0];

  Widget getCupertinoPicker() {
    List<Text> pickeritems = [];
    for (String currency in currenciesList) {
      pickeritems.add(
        Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = pickeritems[selectedIndex].data;
        });
        getUpdatedData();
      },
      children: pickeritems,
    );
  }

  Widget getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (String currency in currenciesList) {
      var newitem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitems.add(newitem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownitems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUpdatedData();
  }

  void getUpdatedData() async {
    int i = 0;
    Convertor cryptoConvertor = Convertor();
    for (String cryptoname in cryptoList) {
      cryptoConvertor.getCurrencyandCrypto(selectedCurrency, cryptoname);
      dynamic data = await cryptoConvertor.getConvertedData();
      double convertedRate = data['rate'];
      setState(() {
        convertedData[i] = double.parse((convertedRate).toStringAsFixed(2));
      });
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ResuableCard(
                selectedCurrency: selectedCurrency,
                rate: convertedData[0],
                crypto: cryptoList[0],
              ),
              ResuableCard(
                selectedCurrency: selectedCurrency,
                rate: convertedData[1],
                crypto: cryptoList[1],
              ),
              ResuableCard(
                selectedCurrency: selectedCurrency,
                rate: convertedData[2],
                crypto: cryptoList[2],
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getCupertinoPicker(),
          ),
        ],
      ),
    );
  }
}
