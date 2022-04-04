import 'package:bus_driver/bus_driver_src/data/transaction/transaction_data.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:flutter/material.dart';
import '../../../common_src/data/network_service.dart';
import '../../../common_src/data/repository.dart';
import '../../../weather_src/constants/app_colors.dart';
import '../../data/models/list_payment_wallet_by_bus_credentials.dart';
import '../../data/models/list_payment_wallet_by_bus_dto.dart';
import '../../helper/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionListWidget extends StatefulWidget {
   TransactionListWidget({Key? key, required this.widgetHeight}) : super(key: key);
  final double? widgetHeight;

  @override
  _TransactionListWidget createState() => _TransactionListWidget();
}

class _TransactionListWidget extends State<TransactionListWidget> {
  late final Repository _repository;
  late final AppData _appData;
  late final  String _busId;
  late final SharedPreferences? _pref;
  List<Transaction> transactionList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _repository = Repository(networkService: NetworkService());
    _appData = AppData();
    _appData.getSharedPreferencesInstance().then((value) {
      _pref = value;
      _busId = _appData.getBusID(_pref!)!;
      getPreviousTransactionList();
    });

    EventBusUtils.getInstance().on<OnNewTransactionEvent>().listen((event) {
      setState(() {
        transactionList.add(event.transaction);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent * 2, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
        flex: 10,
        child: Container(
            color: Colors.white,
            child: SizedBox(
                height: widget.widgetHeight,
                child: new ListView.separated(
                  itemCount: transactionList.length,
                  controller: _scrollController,
                  separatorBuilder: (BuildContext context, int index) => Divider(height: 1,),
                  itemBuilder: (BuildContext context, int index) {return TransactionRow(transaction: transactionList[index],);},
                )
            )
        )
    );
  }

  void getPreviousTransactionList(){
    final listPaymentWalletByBusCredentials = ListPaymentWalletByBusCredentials(id: '$_busId', pageNumber: 1, pageSize: 500);
    _repository.getListPaymentWalletByBus(listPaymentWalletByBusCredentials).then((response) async{
      if (response != null) {
        if(response.status == true){
          setState(() {
            try{
              //print('PreviousTransactionList: ${(response as ListPaymentWalletByBusDTO).description?.first.name}');
              ListPaymentWalletByBusDTO listPaymentWalletByBusDTO = response as ListPaymentWalletByBusDTO;
              listPaymentWalletByBusDTO.description?.forEach((element) {
                setState(() {
                  transactionList.add(Transaction(username: element.name, createdDate: element.date, status: true));
                  _scrollController.animateTo(_scrollController.position.maxScrollExtent * 2, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                });
              });
            }catch(e){
              Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
            }
          });
        }else{
          Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
        }
      }else{
        Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
      }
    });
  }
}

class TransactionRow extends StatelessWidget {
  const TransactionRow({Key? key, required this.transaction}) : super(key: key);
  final Transaction? transaction;
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: AppColors.rainBlueDark);
    return Expanded(
        flex: 1,
        child: ListTile(
          title: new Text(transaction!.username!, style: textStyle,),
          subtitle: new Text(transaction!.time, style: textStyle,),
          leading: new Image(image: AssetImage(transaction!.statusIconPath)),
      )
    );
  }
}