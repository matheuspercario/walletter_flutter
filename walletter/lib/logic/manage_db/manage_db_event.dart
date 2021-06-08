import 'package:walletter/model/transactionModel.dart';

abstract class ManageEvent {}

class DeleteEvent extends ManageEvent {
  var transactionId;
  DeleteEvent({this.transactionId});
}

class SubmitEvent extends ManageEvent {
  TransactionForm transaction;
  SubmitEvent({this.transaction});
}
