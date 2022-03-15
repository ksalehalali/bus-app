import 'package:bus_driver/bus_driver_src/constants/network_constants.dart';
import 'package:bus_driver/bus_driver_src/data/transaction/transaction_data.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../weather_src/constants/app_colors.dart';
import '../../data/transaction/transaction_type.dart';
import 'package:signalr_core/signalr_core.dart';

class TransactionListWidget extends StatefulWidget {
   TransactionListWidget({Key? key, required this.widgetHeight}) : super(key: key);
  final double? widgetHeight;

   List<Transaction> transactionList = [
    /*
    Transaction(username: 'Abdulaziz Al-Fouzan', timestamp: 1645563186, status: TransactionType.Success.name),
    Transaction(username: 'Latifa Esbaitah', timestamp: 1645563124, status: TransactionType.Success.name),
    Transaction(username: 'Abdullah', timestamp: 1645563060, status: TransactionType.Failed.name),
    Transaction(username: 'Mshary', timestamp: 1645521392, status: TransactionType.Success.name),
    Transaction(username: 'Soliman', timestamp: 1645521092, status: TransactionType.Failed.name),
    Transaction(username: 'Saad', timestamp: 1645520852, status: TransactionType.Failed.name),
    Transaction(username: 'Mshary Ahmed', timestamp: 1645513652, status: TransactionType.Success.name),
    Transaction(username: 'Soliman Mohammed', timestamp: 1645513532, status: TransactionType.Failed.name),
    Transaction(username: 'Saad Mousa', timestamp: 1645513352, status: TransactionType.Success.name),
    */
  ];

  @override
  _TransactionListWidget createState() => _TransactionListWidget();
}

class _TransactionListWidget extends State<TransactionListWidget> {



  @override
  void initState() {
    super.initState();
    EventBusUtils.getInstance().on<OnNewTransactionEvent>().listen((event) {
      setState(() {
        widget.transactionList.add(event.transaction);
      //  widget.transactionList.add(Transaction(username: 'Abdulaziz Al-Fouzan', timestamp: 1645563186, status: TransactionType.Success.name));
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
                child:   new ListView.separated(
                  itemCount: widget.transactionList.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(height: 1,),
                  itemBuilder: (BuildContext context, int index) {
                    return TransactionRow(transaction: widget.transactionList[index],);
                  },
                )
            )
        )
    );
  }

}

class TransactionRow extends StatelessWidget {
  const TransactionRow({Key? key, required this.transaction}) : super(key: key);
  final Transaction? transaction;
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: AppColors.rainBlueDark);
    final textTheme = Theme.of(context).textTheme;
    final fontWeight = FontWeight.normal;
    return Expanded(
        flex: 1,
        child: ListTile(
          title: new Text(transaction!.username!, style: textStyle,),
          subtitle: new Text(transaction!.createdTime!, style: textStyle,),
          leading: new Image(image: AssetImage(transaction!.statusIconPath)),
      )
    );
  }
}