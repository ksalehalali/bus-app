import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomingWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    cryptoPortfolioItem(bool isIncoming, String name, double amount, double rate, String percentage) => Card(
      elevation: 1.0,
      child: InkWell(
        onTap: () => print("tapped"),
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 15.0, right: 15.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 10.0, right: 15.0), child: getIcon(isIncoming),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),),
                        Text("${getSign(isIncoming)} \ $percentage", style: TextStyle(fontSize: 14.0, color: getColor(isIncoming),))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("$rate BTC", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: Colors.grey)),
                        Text("\KWD $amount", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black))
                      ],
                    )
                  ],
                ),
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );


    return Container(
      child: Center(
          child:
                ListView(
                  children: <Widget>[
                    cryptoPortfolioItem(true, "Cash", 100.800, 0.0036, "82.19"),
                    cryptoPortfolioItem(false, "Cash", 20, 126.0, "13.10"),
                    cryptoPortfolioItem(false, "Visa", 3, 23000, "120"),
                    cryptoPortfolioItem(false, "Cash", 42.500, 0.0036, "82.19"),
                    cryptoPortfolioItem(true, "Visa", 500, 126.0, "13.10"),
                    cryptoPortfolioItem(true, "Cash", 230, 23000, "120"),
                    cryptoPortfolioItem(true, "Cash", 90, 0.0036, "82.19"),
                    cryptoPortfolioItem(true, "Visa", 33, 126.0, "13.10"),
                    cryptoPortfolioItem(false, "Visa", 20.600, 23000, "120"),
                  ],
                ),

      ),
    );
  }

  getIcon(bool isIncoming) {
    if(isIncoming) return Icon(FontAwesomeIcons.plus, color: Colors.green,); else return Icon(FontAwesomeIcons.minus, color: Colors.red,);
  }

  getSign(bool isIncoming) {
    if(isIncoming) return "+"; else return "-";
  }

  getColor(bool isIncoming) {
    if(isIncoming) return Colors.green; else return Colors.red;
  }
}