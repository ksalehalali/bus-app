import 'package:bus_driver/bus_driver_src/data/transaction/transaction_data.dart';

class OnNewTransactionEvent{
  Transaction transaction;
  OnNewTransactionEvent(this.transaction);
}