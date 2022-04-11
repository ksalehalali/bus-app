import 'package:bus_driver/bus_promoter_src/view/wallet/wallet_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common_src/constants/app_colors.dart';

class IncomingWallet extends StatefulWidget {
  IncomingWallet({Key? key}) : super(key: key);

  @override
  _IncomingWallet createState() => _IncomingWallet();
}

class _IncomingWallet extends State<IncomingWallet> {
  List<Color> currentGradientColors = AppColors.activeGradient;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:
        ListView(
          children: <Widget>[
            walletItemWidget(true, "Cash", 100.800, 0.0036, "82.19"),
            walletItemWidget(true, "Cash", 20, 126.0, "13.10"),
            walletItemWidget(true, "Visa", 3, 23000, "120"),
            walletItemWidget(true, "Cash", 42.500, 0.0036, "82.19"),
            walletItemWidget(true, "Visa", 500, 126.0, "13.10"),
            walletItemWidget(true, "Cash", 230, 23000, "120"),
            walletItemWidget(true, "Cash", 90, 0.0036, "82.19"),
            walletItemWidget(true, "Visa", 33, 126.0, "13.10"),
            walletItemWidget(true, "Visa", 20.600, 23000, "120"),
          ],
        ),
      ),
    );
  }
}