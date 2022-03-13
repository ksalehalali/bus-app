import 'package:bus_driver/bus_driver_src/data/route/route_data.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/route_information_widget.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/total_transaction_count_widget.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/transaction_list.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/screen_size.dart';
import 'package:signalr_client/signalr_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.routeData}) : super(key: key);
  final RouteData? routeData;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final serverUrl = "https://route.click68.com/DashHub";
  HubConnection? hubConnection;


  @override
  void initState() {
    super.initState();
    //initPlatformState();
    initSignalR();
  }

  /*
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
   /*
    signalR = SignalR(
        'https://route.click68.com',
        'DashHub',
       // hubMethods: ['PaymentCount', 'PaymentValueCount', 'PaymentLive'],
        statusChangeCallback: _onStatusChange,
        hubCallback: _onNewMessage,);
    */

    // Configer the logging
    final logger = Logger.root;
    logger.level = Level.ALL;
// Writes the log messages to the console
    logger.onRecord.listen((LogRecord rec) {
      print('SignalR... onRecord:  ${rec.level.name}: ${rec.time}: ${rec.message}');
    });

// If you want only to log out the message for the higer level hub protocol:
    final hubProtLogger = Logger("SignalR - hub");
// If youn want to also to log out transport messages:
    final transportProtLogger = Logger("SignalR - transport");

// The location of the SignalR Server.
    // final serverUrl = "192.168.10.50:51001";
   // final serverUrl = "https://route.click68.com/DashHub";
    final serverUrl = "https://stage.location.hubs.routesme.com/trackServiceHub?vehicleId=3342424&institutionId=4832645245&deviceId=hhdgsdsf";

    final connectionOptions = HttpConnectionOptions;
    final httpOptions = new HttpConnectionOptions(logger: logger);
    final _appData = AppData();
    httpOptions.headers = ["Authorization:"];
    httpOptions.skipNegotiation = true;
    httpOptions.transport = HttpTransportType.WebSockets;
//final httpOptions = new HttpConnectionOptions(logger: transportProtLogger, transport: HttpTransportType.WebSockets); // default transport type.
//final httpOptions = new HttpConnectionOptions(logger: transportProtLogger, transport: HttpTransportType.ServerSentEvents);
//final httpOptions = new HttpConnectionOptions(logger: transportProtLogger, transport: HttpTransportType.LongPolling);

// If you need to authorize the Hub connection than provide a an async callback function that returns
// the token string (see AccessTokenFactory typdef) and assigned it to the accessTokenFactory parameter:
// final httpOptions = new HttpConnectionOptions( .... accessTokenFactory: () async => await getAccessToken() );

// Creates the connection by using the HubConnectionBuilder.
    hubConnection = HubConnectionBuilder().withUrl(serverUrl, options: httpOptions).withAutomaticReconnect().configureLogging(logger).build();
/*
    hubConnection =  HubConnectionBuilder()
        .configureLogging(hubProtLogger)
        .withUrl(serverUrl, {
      skipNegotiation: true,
      transport: signalR.HttpTransportType.WebSockets
    }).build();
    */
// When the connection is closed, print out a message to the console.
    hubConnection.onclose(({error}) {
      print("SignalR... Connection Closed... Error: $error");
    });
    /*
    hubConnection.onclose( (error){
      print("Connection Closed");
    });
    */
  }
*/

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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

          hubConnection?.state == HubConnectionState.Disconnected ?
              await hubConnection?.start():
              await hubConnection?.stop();


          /*
          final connectionState = await hubConnection.state;
          if (connectionState == HubConnectionState.Disconnected) {
            try{
              await hubConnection.start();
            }catch(error){
              print("SignalR...  Error: $error");
            }
          } else {
            await hubConnection.stop();
          }
          */
        },
      ),
    );
  }

  void initSignalR() {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection?.onclose((error) => print('Connection close'));
    hubConnection?.on("PaymentLive", _handleNewPayment);
  }

   _handleNewPayment(List<Object> args) {

  }


/*
  _onStatusChange(dynamic status) {
    if (mounted) {
      setState(() {
        _signalRStatus = status as String;
        print("SignalR...  _onStatusChange: $_signalRStatus");
        Fluttertoast.showToast(msg: "SignalR...  _onStatusChange: $_signalRStatus", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
      });
    }
  }

  _onNewMessage(String? methodName, dynamic message) {
    print('SignalR... MethodName = $methodName, Message = $message');
    Fluttertoast.showToast(msg: "SignalR onNewMessage: MethodName = $methodName, Message = $message", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);

  }
 */
/*
  _buttonTapped() async {
    final res = await signalR.invokeMethod<dynamic>("<Your Method Name>",
        arguments: ["<Your Method Arguments>"]).catchError((error) {
      print(error.toString());
    });
    final snackBar = SnackBar(content: Text('SignalR Method Response: $res'));
    rootScaffoldMessengerKey.currentState!.showSnackBar(snackBar);
  }
  */
}
