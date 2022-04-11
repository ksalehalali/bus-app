import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

walletItemWidget(bool isIncoming, String name, double amount, double rate, String percentage) => Card(
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


getIcon(bool isIncoming) {
  if(isIncoming) return Icon(FontAwesomeIcons.plus, color: Colors.green,); else return Icon(FontAwesomeIcons.minus, color: Colors.red,);
}

getSign(bool isIncoming) {
  if(isIncoming) return "+"; else return "-";
}

getColor(bool isIncoming) {
  if(isIncoming) return Colors.green; else return Colors.red;
}