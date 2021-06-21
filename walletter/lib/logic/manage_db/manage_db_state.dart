import 'package:walletter/model/transactionModel.dart';

abstract class ManageState {}

class UpdateState extends ManageState {
  var transactionId;
  TransactionForm previousTransaction;
  UpdateState({this.transactionId, this.previousTransaction});
}

class InsertState extends ManageState {}
