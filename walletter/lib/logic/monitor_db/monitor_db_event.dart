import 'package:walletter/model/transactionModel.dart';

abstract class MonitorEvent {}

class AskNewList extends MonitorEvent {}


class UpdateList extends MonitorEvent {
  List<TransactionForm> transactionList;
  List<dynamic> idList;
  UpdateList({this.transactionList, this.idList});
}
