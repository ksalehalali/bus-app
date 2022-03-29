import 'package:bus_driver/bus_driver_src/view/home_page/route_information_widget.dart';
import 'package:bus_driver/bus_driver_src/view/home_page/total_transaction_count_widget.dart';
import 'package:bus_driver/bus_driver_src/view/home_page/transaction_list.dart';
import 'package:flutter/material.dart';
import '../../common_src/constants/app_colors.dart';
import '../../common_src/constants/screen_size.dart';

class DriverHomePage extends StatefulWidget {
  DriverHomePage({Key? key}) : super(key: key);

  @override
  _DriverHomePage createState() => _DriverHomePage();
}

class _DriverHomePage extends State<DriverHomePage> {

  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  List<Color> currentGradientColors = AppColors.activeGradient;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var screenSize = ScreenSize();

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: currentGradientColors,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 2),
              RouteInformationWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 10),
              const SizedBox(height: 2),
              TransactionListWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 80),
              const SizedBox(height: 2),
              TotalTransactionCountWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 10),
              const SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
  }
}