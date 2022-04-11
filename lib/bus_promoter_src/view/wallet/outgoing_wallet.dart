import 'package:bus_driver/bus_promoter_src/view/wallet/wallet_item_widget.dart';
import 'package:flutter/material.dart';
import '../../../common_src/constants/app_colors.dart';

class OutgoingWallet extends StatefulWidget {
  OutgoingWallet({Key? key}) : super(key: key);

  @override
  _OutgoingWallet createState() => _OutgoingWallet();
}

class _OutgoingWallet extends State<OutgoingWallet> {
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
            walletItemWidget(false, "Cash", 100.800, 0.0036, "82.19"),
            walletItemWidget(false, "Cash", 20, 126.0, "13.10"),
            walletItemWidget(false, "Visa", 3, 23000, "120"),
            walletItemWidget(false, "Cash", 42.500, 0.0036, "82.19"),
            walletItemWidget(false, "Visa", 500, 126.0, "13.10"),
            walletItemWidget(false, "Cash", 230, 23000, "120"),
            walletItemWidget(false, "Cash", 90, 0.0036, "82.19"),
            walletItemWidget(false, "Visa", 33, 126.0, "13.10"),
            walletItemWidget(false, "Visa", 20.600, 23000, "120"),
          ],
        ),
      ),
    );
  }
}