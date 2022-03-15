import 'package:bus_driver/bus_driver_src/data/models/signalr_transaction_dto.dart';
import 'package:bus_driver/bus_driver_src/data/route/route_data.dart';
import 'package:bus_driver/bus_driver_src/data/transaction/transaction_data.dart';
import 'package:bus_driver/bus_driver_src/data/transaction/transaction_type.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/route_information_widget.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/total_transaction_count_widget.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/transaction_list.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:bus_driver/bus_driver_src/helper/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/network_constants.dart';
import '../../constants/screen_size.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:event_bus/event_bus.dart';

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
 // TotalTransactionCountWidget? totalTransactionCountWidget;
  //late final AppData _appData;
  
  @override
  void initState() {
    eventBus = EventBusUtils.getInstance();
    super.initState();
    
/*
    _appData = AppData();
    _appData.getSharedPreferencesInstance().then((pref) {
      final accessToken = _appData.getAccessToken(pref!);
     // signalrCore(accessToken);
    });
    */

  }

  Future<void> initSignalR() async {
    final connection = HubConnectionBuilder().withUrl(NetworkConstants().liveTransactionServerUrl,
        HttpConnectionOptions(
         // accessTokenFactory: () async => await liveTransactionAccessToken,
          transport: HttpTransportType.webSockets,
          logging: (level, message){
           // eventBus.fire(OnNewTransactionEvent(Transaction(username: 'Abdulaziz Al-Fouzan ${count++}', timestamp: 1645563186, status: TransactionType.Success.name)));
           // eventBus.fire(OnNewTransactionEvent());
           // widget.eventBus.fire(OnNewTransactionEvent());
            print("SignalRCore... logging.. Level: $level, Message: ${message.toString()}");
          }
        )).build();
    connection.serverTimeoutInMilliseconds = Duration(minutes: 6).inMilliseconds;
    connection.onclose((exception) => print("SignalRCore... onclose.. Exception: $exception"));
    connection.onreconnected((connectionId) => print("SignalRCore... onreconnected.. ConnectionId: $connectionId"));

    //لسينر عدد الدفعات
    connection.on('PaymentCount', (message) {print("SignalRCore... onPaymentCount.. Message: ${message!.first}");});
    //لسينر قيمه الدفعات
    connection.on('PaymentValueCount', (message) {print("SignalRCore... onPaymentValueCount.. Message: ${message!.first}");});
    //لسينر الدفعه الواحده
    connection.on('PaymentLive', (message) {
      print("SignalRCore... onPaymentLive.. Message: ${message!.first}");
      Data data = Data.fromJson(message.first);
      print("SignalRCore... onPaymentLive.. Message Data: ${data.name}");
      eventBus.fire(OnNewTransactionEvent(Transaction(username: data.name, createdTime: data.time, status: data.status)));
     // eventBus.fire(OnNewTransactionEvent(Transaction(username: 'Abdulaziz Al-Fouzan ${count++}', timestamp: 1645563186, status: TransactionType.Success.name)));
    });

    await connection.start();

   // await connection.invoke('SendMessage', args: ['Bob', 'Says hi!']);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var screenSize = ScreenSize();
    initSignalR();
   // totalTransactionCountWidget = TotalTransactionCountWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 10);

    return Scaffold(
     // appBar: AppBar(title: Text("Bus driver app"),),
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
/*
      floatingActionButton: Visibility(
        visible: true,
        child:  FloatingActionButton(
          onPressed: () async {EventBusUtils.getInstance().fire(OnNewTransactionEvent(Transaction(username: 'Abdulaziz Al-Fouzan', timestamp: 1645563186, status: TransactionType.Success.name)));},
          tooltip: 'Increment',
          child:  Icon(Icons.add),
        ),
      ),
*/
    );
  }



/*
  @override
  void dispose() {
    super.dispose();
    //Close the event event stream, otherwise it will cause memory leakage. Call the following code:
    EventBusUtils.getInstance().destroy();
  }
  */
}