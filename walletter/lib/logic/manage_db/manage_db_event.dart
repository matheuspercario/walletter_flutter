import 'package:walletter/model/transactionModel.dart';

abstract class ManageEvent {}

class DeleteEvent extends ManageEvent {
  var transactionId;
  DeleteEvent({this.transactionId});
}

class UpdateRequest extends ManageEvent {
  var transactionId;
  TransactionForm previousTransaction;
  UpdateRequest({this.transactionId, this.previousTransaction});
}

class UpdateCancel extends ManageEvent {}

class SubmitEvent extends ManageEvent {
  TransactionForm transaction;
  SubmitEvent({this.transaction});
}
