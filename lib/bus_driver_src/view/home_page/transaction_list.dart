import 'package:bus_driver/bus_driver_src/data/transaction/transaction_data.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../common_src/constants/app_colors.dart';

class TransactionListWidget extends StatefulWidget {
   TransactionListWidget({Key? key, required this.widgetHeight, required this.transactionList}) : super(key: key);
   final double? widgetHeight;
   final List<Transaction> transactionList;

  @override
  _TransactionListWidget createState() => _TransactionListWidget();
}

class _TransactionListWidget extends State<TransactionListWidget> {
  final ScrollController _scrollController = ScrollController();

  final scrollDirection = Axis.vertical;
  AutoScrollController? controller;

  @override
  void initState() {
    super.initState();
    EventBusUtils.getInstance().on<OnNewTransactionEvent>().listen((event) {
      setState(() {
        widget.transactionList.add(event.transaction);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent * 2, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
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
                  reverse: false,
                  itemCount: widget.transactionList.length,
                  controller: _scrollController,
                  separatorBuilder: (BuildContext context, int index) => Divider(height: 1,),
                  itemBuilder: (BuildContext context, int index) {return TransactionRow(transaction: widget.transactionList[index],);},
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