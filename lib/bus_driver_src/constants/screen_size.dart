import 'package:flutter/cupertino.dart';

class ScreenSize{
  static final ScreenSize _screenSize = ScreenSize._internal();

  factory ScreenSize() {
    return _screenSize;
  }

  ScreenSize._internal();

  double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width/10;
  double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height/10;
  EdgeInsets getScreenPadding(BuildContext context) => MediaQuery.of(context).padding;

  double getScreenHeightExcludeSafeArea(BuildContext context) {
    final double height =  getScreenHeight(context);
    final EdgeInsets padding = getScreenPadding(context);
    return (height - padding.top - padding.bottom)/100;
  }
}