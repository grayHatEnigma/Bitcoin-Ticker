import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/utilities/coin.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen>
    with SingleTickerProviderStateMixin {
  // Variables
  String selectedCurrency = currenciesList.first;
  CoinData coinData = CoinData();
  double price = 0;
  bool isWaiting = true;

  @override
  void initState() {
    super.initState();
    getPrice();
  }

  /// The Magic Function all the app magic is here :D !2
  void getPrice() async {
    isWaiting = true;
    var dataPrice = await coinData.getPrice(
        caller: 'getPrice function', currency: selectedCurrency);
    isWaiting = false;
    print('debugging: new http request - done');
    setState(() {
      price = dataPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: coinData.getPrice(
              caller: 'FutureBuilder object', currency: selectedCurrency),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image(
                      image: AssetImage('images/bitcoin.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  isWaiting
                      ? SpinKitFadingCircle(
                          color: Colors.lightBlue,
                          size: 70.0,
                        )
                      : Text(
                          '${FlutterMoneyFormatter(amount: price).output.withoutFractionDigits}  $selectedCurrency',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 44,
                            color: Colors.black,
                            fontFamily: 'Cutive',
                          ),
                        ),
                  Container(
                    height: 150.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 30.0),
                    color: Colors.lightBlue,
                    child: iosPicker(),
                  ),
                ],
              );
            }
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.lightBlue,
                size: 70.0,
              ),
            );
          }),
    );
  }

  /// build end

  ///  Picker Method
  CupertinoPicker iosPicker() {
    List<Text> cupertinoItems = List();
    for (String e in currenciesList) {
      cupertinoItems.add(Text(e));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        print(selectedCurrency);
        getPrice();
      },
      children: cupertinoItems,
    );
  } // iosPicker
} //class
