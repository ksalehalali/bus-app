import 'package:bus_driver/bus_driver_src/data/route/route_data.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/route_information_widget.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/total_transaction_count_widget.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/transaction_list.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/screen_size.dart';
import 'package:signalr_flutter/signalr_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.routeData}) : super(key: key);
  final RouteData? routeData;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String _signalRStatus = 'Unknown';
  late SignalR signalR;
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    signalR = SignalR(
        'https://route.click68.com/api',
        '/PaymentCount',
       // hubMethods: ["<Your Hub Method Names>"],
        statusChangeCallback: _onStatusChange,
        hubCallback: _onNewMessage);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    var screenSize = ScreenSize();
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.rainGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 2),
              RouteInformationWidget(
                  widgetHeight: screenSize.getScreenHeightExcludeSafeArea(
                      context) * 0.1, routeData: widget.routeData),
              const SizedBox(height: 2),
              TransactionListWidget(
                  widgetHeight: screenSize.getScreenHeightExcludeSafeArea(
                      context) * 9.8),
              const SizedBox(height: 2),
              TotalTransactionCountWidget(
                  widgetHeight: screenSize.getScreenHeightExcludeSafeArea(
                      context) * 0.1,
                  totalSuccessTransactionCount: 5,
                  totalFailedTransactionCount: 4),
              const SizedBox(height: 2),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cast_connected),
        onPressed: () async {
          final isConnected = await signalR.isConnected ?? false;
          if (!isConnected) {
            await signalR.connect();
          } else {
            signalR.stop();
          }
        },
      ),
    );
  }

  _onStatusChange(dynamic status) {
    if (mounted) {
      setState(() {
        _signalRStatus = status as String;
        Fluttertoast.showToast(msg: "SignalR _onStatusChange: $_signalRStatus", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
      });
    }
  }

  _onNewMessage(String? methodName, dynamic message) {
    print('MethodName = $methodName, Message = $message');
    Fluttertoast.showToast(msg: "SignalR onNewMessage: MethodName = $methodName, Message = $message", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);

  }

  _buttonTapped() async {
    final res = await signalR.invokeMethod<dynamic>("<Your Method Name>",
        arguments: ["<Your Method Arguments>"]).catchError((error) {
      print(error.toString());
    });
    final snackBar = SnackBar(content: Text('SignalR Method Response: $res'));
    rootScaffoldMessengerKey.currentState!.showSnackBar(snackBar);
  }
}
