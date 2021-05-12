import 'package:walletter/model/transactionModel.dart';

abstract class MonitorEvent {}

class AskNewList extends MonitorEvent {}

class UpdateList extends MonitorEvent {
  List<TransactionForm> transactionList;
  List<int> idList;
  UpdateList({this.transactionList, this.idList});
}
