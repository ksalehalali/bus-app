import 'package:bus_driver/bus_driver_src/data/transaction/transaction_type.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:flutter/material.dart';

class TotalTransactionCountWidget extends StatefulWidget {
   TotalTransactionCountWidget({Key? key, required this.widgetHeight}) : super(key: key);
  final double? widgetHeight;
  int totalSuccessTransactionCount = 0;
  int totalFailedTransactionCount = 0;

  @override
  _TotalTransactionCountWidget createState() => _TotalTransactionCountWidget();
}

class _TotalTransactionCountWidget extends State<TotalTransactionCountWidget> {

  @override
  void initState() {
    super.initState();
    EventBusUtils.getInstance().on<OnNewTransactionEvent>().listen((event) {
      setState(() {if(event.transaction.status == true) widget.totalSuccessTransactionCount++; else widget.totalFailedTransactionCount++;});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: SizedBox(
          height: widget.widgetHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              Text('Total transaction count', style: TextStyle(color: Colors.white),),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  TotalTransactionCountItem(type: '${TransactionType.Success.name}', count: widget.totalSuccessTransactionCount),//totalSuccessTransactionCount),
                  const Spacer(),
                  TotalTransactionCountItem(type: '${TransactionType.Failed.name}', count: widget.totalFailedTransactionCount),
                  const Spacer(),
                ],
              ),
            ],
          )
        )
    );
  }
}

class TotalTransactionCountItem extends StatelessWidget {
  const TotalTransactionCountItem({Key? key, required this.type, required this.count}) : super(key: key);
  final String? type;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Text('$type', style: TextStyle(color: Colors.white),),
          const SizedBox(height: 3),
          Text('$count', style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}