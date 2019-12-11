import 'package:bitcoin_ticker/services/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/utilities/coin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen>
    with SingleTickerProviderStateMixin {
  // Variables
  Future<double> priceData;
  String selectedCurrency = currenciesList.first;
  double price = 0;
  NetworkHelper networkHelper;

  @override
  void initState() {
    super.initState();
    networkHelper = NetworkHelper();
    priceData = getPrices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Coin Ticker',
                style: TextStyle(fontSize: 25),
              ),
              Icon(
                Icons.attach_money,
                color: Colors.green[900],
              ),
            ],
          )),
      body: FutureBuilder(
        future: priceData,
        // you should put here your method that call your web service
        builder: (context, snapshot) {
          /// The snapshot data type have to be same of the result of your web service method
          if (snapshot.hasData) {
            /// When the result of the future call respond and has data show that data
            priceData.then((value) => price = value);
            return Column(
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
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 BTC = ${price.toStringAsFixed(2)} $selectedCurrency',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
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

          /// While is no data show this
          return Center(
            child: SpinKitCircle(
              color: Colors.lightBlue,
              size: 70.0,
            ),
          );
        },
      ),
    );
  } // build

  Future<double> getPrices() async {
    var btc =
        await networkHelper.getPrice(crypto: 'BTC', currency: selectedCurrency);

    setState(() {
      price = btc['averages']['day'];
    });
    return btc['averages']['day'];
  }

  CupertinoPicker iosPicker() {
    List<Text> cupertinoItems = List();
    for (String e in currenciesList) {
      cupertinoItems.add(Text(e));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        selectedCurrency = currenciesList[selectedIndex];
        getPrices();
      },
      children: cupertinoItems,
    );
  } // iosPicker
} //class

//DropdownButton androidPicker() {
//  List<DropdownMenuItem<String>> dropDownItems = List();
//  for (String e in currenciesList) {
//    dropDownItems.add(DropdownMenuItem(
//      child: Text(e),
//      value: e,
//    ));
//  }
//  return DropdownButton(
//    value: selectedCurrency,
//    items: dropDownItems,
//    onChanged: (value) {
//      setState(
//            () {
//          selectedCurrency = value;
//        },
//      );
//    },
//  );
//} // androidPicker
