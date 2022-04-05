import 'package:bus_driver/bus_driver_src/data/models/signalr_transaction_dto.dart';
import 'package:bus_driver/bus_driver_src/data/transaction/transaction_data.dart';
import 'package:bus_driver/bus_driver_src/view/home_page/route_information_widget.dart';
import 'package:bus_driver/bus_driver_src/view/home_page/total_transaction_count_widget.dart';
import 'package:bus_driver/bus_driver_src/view/home_page/transaction_list.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_beep/flutter_beep.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/constants/network_constants.dart';
import '../../../common_src/constants/screen_size.dart';
import '../../../common_src/data/network_service.dart';
import '../../../common_src/data/repository.dart';
import '../../data/models/list_payment_wallet_by_bus_credentials.dart';
import '../../data/models/list_payment_wallet_by_bus_dto.dart';
import '../../helper/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DriverHomePage extends StatefulWidget {
  DriverHomePage({Key? key}) : super(key: key);

  @override
  _DriverHomePage createState() => _DriverHomePage();
}

class _DriverHomePage extends State<DriverHomePage> {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  late EventBus eventBus;
  int count = 0;
  HubConnection? connection;
  List<Color> currentGradientColors = AppColors.activeGradient;
  List<Transaction> transactionList = [];
  late final Repository _repository;
  late final AppData _appData;
  late final  String _busId;
  late final SharedPreferences? _pref;

  @override
  void initState() {
    getPreviousTransactionList();
    eventBus = EventBusUtils.getInstance();
    _initSignalR();
    notificationsInitialize();
    super.initState();
  }

  void getPreviousTransactionList(){
    List<Transaction> previousTransactionList = [];
    _repository = Repository(networkService: NetworkService());
    _appData = AppData();
    _appData.getSharedPreferencesInstance().then((value) {
      _pref = value;
      _busId = _appData.getBusID(_pref!)!;
      final listPaymentWalletByBusCredentials = ListPaymentWalletByBusCredentials(id: '$_busId', pageNumber: 1, pageSize: 500);
      _repository.getListPaymentWalletByBus(listPaymentWalletByBusCredentials).then((response) async{
        if (response != null) {
          if(response.status == true){
              try{

               // setState(() {
                  ListPaymentWalletByBusDTO listPaymentWalletByBusDTO = response as ListPaymentWalletByBusDTO;
                  listPaymentWalletByBusDTO.description?.forEach((element) {
                    previousTransactionList.add(Transaction(username: element.name, createdDate: element.time, status: true));
                  });
               // });
                setState(() {
                  transactionList.addAll(previousTransactionList);
                });
              }catch(e){
                Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
              }
          }else{
            Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
          }
        }else{
          Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
        }
      });
    });
  }

  Future<void> _initSignalR() async {
     connection = HubConnectionBuilder().withUrl(NetworkConstants().liveTransactionServerUrl,
        HttpConnectionOptions(
         // accessTokenFactory: () async => await liveTransactionAccessToken,
          transport: HttpTransportType.webSockets,
          logging: (level, message){
            if(message.contains('HubConnection connected successfully')){
              eventBus.fire(OnSignalRStatusChanged(true));
            }
            print("SignalRCore... logging.. Level: $level, Message: ${message.toString()}");
          }
        )).build();
    connection?.serverTimeoutInMilliseconds = Duration(minutes: 6).inMilliseconds;
    connection?.onclose((exception) {
      eventBus.fire(OnSignalRStatusChanged(false));
      print("SignalRCore... onclose.. Exception: $exception");
    });
    connection?.onreconnected((connectionId){
      eventBus.fire(OnSignalRStatusChanged(true));
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
              TransactionListWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 80, transactionList: transactionList),
              const SizedBox(height: 2),
              TotalTransactionCountWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 10, totalSuccessTransactionCount: transactionList.length, totalFailedTransactionCount: 0),
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

  notificationsInitialize() {
    requestPermission();
    notificationsInterminatedStateInitialize() ;
    notificationsInBackgroundStateInitialize();
    notificationsInForegroundStateInitialize();
  }

  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  notificationsInterminatedStateInitialize() async {
    var message =   await FirebaseMessaging.instance.getInitialMessage() ;
    if (message != null){
      //showNotificationDialog(message);
      print("NotificationTesting : notificationsInterminatedStateInitialize... Message.notification: ${message.notification!.body}");
    }
  }

  notificationsInBackgroundStateInitialize() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
       // showNotificationDialog(message);
        print("NotificationTesting : notificationsInBackgroundStateInitialize... Message.notification: ${message.notification!.body}");
      }
    });
  }

  notificationsInForegroundStateInitialize() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message != null) {
       // showNotificationDialog(message);
        print("NotificationTesting : notificationsInForegroundStateInitialize... Message.notification: ${message.notification!.body}");
      }
    }) ;
  }
}