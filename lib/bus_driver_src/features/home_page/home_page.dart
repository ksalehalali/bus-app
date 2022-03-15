import 'package:bus_driver/bus_driver_src/data/models/signalr_transaction_dto.dart';
import 'package:bus_driver/bus_driver_src/data/route/route_data.dart';
import 'package:bus_driver/bus_driver_src/data/transaction/transaction_data.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/route_information_widget.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/total_transaction_count_widget.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/transaction_list.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/network_constants.dart';
import '../../constants/screen_size.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:flutter_beep/flutter_beep.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.routeData}) : super(key: key);
  final RouteData? routeData;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  late EventBus eventBus;
  int count = 0;
  HubConnection? connection;
  List<Color> currentGradientColors = AppColors.activeGradient;
 // HubConnectionState signalRStatus = HubConnectionState.disconnected;

  @override
  void initState() {
    eventBus = EventBusUtils.getInstance();
    super.initState();
  }

  Future<void> _initSignalR() async {
     connection = HubConnectionBuilder().withUrl(NetworkConstants().liveTransactionServerUrl,
        HttpConnectionOptions(
         // accessTokenFactory: () async => await liveTransactionAccessToken,
          transport: HttpTransportType.webSockets,
          logging: (level, message){
           // HubConnectionState newStatus = connection!.state!;
           // if(newStatus != signalRStatus){
             // setState(() {
                if(message.contains('HubConnection connected successfully')){
                  eventBus.fire(OnSignalRStatusChanged(true));

                  /*
                  setState(() {
                    currentGradientColors = AppColors.activeGradient;
                  });
                  */
                }
               // if(newStatus == HubConnectionState.connected) currentGradientColors = AppColors.activeGradient;
               // else currentGradientColors = AppColors.inactiveGradient;

               // signalRStatus = newStatus;
             // });
           // }
            print("SignalRCore... logging.. Level: $level, Message: ${message.toString()}");
          }
        )).build();
    connection?.serverTimeoutInMilliseconds = Duration(minutes: 6).inMilliseconds;
    connection?.onclose((exception) {
      eventBus.fire(OnSignalRStatusChanged(false));
     /*
      setState(() {
        currentGradientColors = AppColors.inactiveGradient;
      });
      */

      print("SignalRCore... onclose.. Exception: $exception");
    });
    connection?.onreconnected((connectionId){
      eventBus.fire(OnSignalRStatusChanged(true));
     /*
      setState(() {
        currentGradientColors = AppColors.activeGradient;
      });
      */

      print("SignalRCore... onreconnected.. ConnectionId: $connectionId");
    });

    //Transactions count listener
    connection?.on('PaymentCount', (message) {print("SignalRCore... onPaymentCount.. Message: ${message!.first}");});
     //Transactions value listener
    connection?.on('PaymentValueCount', (message) {print("SignalRCore... onPaymentValueCount.. Message: ${message!.first}");});
     //Transactions listener
    connection?.on('PaymentLive', (message) async {
      print("SignalRCore... onPaymentLive.. Message: ${message!.first}");
      SignalRTransactionDTO signalRTransactionDTO = SignalRTransactionDTO.fromJson(message.first);
      eventBus.fire(OnNewTransactionEvent(Transaction(username: signalRTransactionDTO.name, createdDate: signalRTransactionDTO.time, status: signalRTransactionDTO.status)));
      FlutterBeep.beep(signalRTransactionDTO.status!);
      // bool canVibrate = await Vibrate.canVibrate;
      //if (canVibrate == true) {Vibrate.feedback(FeedbackType.success);}
    });

    await connection?.start();
   // await connection.invoke('SendMessage', args: ['Bob', 'Says hi!']);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var screenSize = ScreenSize();
    _initSignalR();

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
              RouteInformationWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 10, routeData: widget.routeData),
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
    print("SignalRCore... dispose state");
    connection?.stop();
    super.dispose();
  }
}