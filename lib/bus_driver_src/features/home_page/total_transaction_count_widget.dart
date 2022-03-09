import 'package:bus_driver/bus_driver_src/data/transaction/transaction_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalTransactionCountWidget extends StatelessWidget {
  const TotalTransactionCountWidget({Key? key, required this.widgetHeight, this.totalSuccessTransactionCount,  this.totalFailedTransactionCount}) : super(key: key);
  final double? widgetHeight;
  final int? totalSuccessTransactionCount;
  final int? totalFailedTransactionCount;

  @override
  Widget build(BuildContext context) {
     final textTheme = Theme.of(context).textTheme;
    return Expanded(
        flex: 2,
        child: SizedBox(
          height: widgetHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              Text('Total transaction count', style: textTheme.subtitle1,),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  TotalTransactionCountItem(type: '${TransactionType.Success.name}', count: totalSuccessTransactionCount),
                  const Spacer(),
                  TotalTransactionCountItem(type: '${TransactionType.Failed.name}', count: totalFailedTransactionCount),
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
    final textTheme = Theme.of(context).textTheme;
    final fontWeight = FontWeight.normal;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Text('$type', style: textTheme.subtitle1,),
          const SizedBox(height: 3),
          Text('$count', style: textTheme.subtitle1,),
        ],
      ),
    );
  }
}