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
            WalletItemWidget(false, "Cash", '100.800',"30"),
          ],
        ),
      ),
    );
  }
}