import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:walletter/data/firestore_database.dart';
import 'package:walletter/logic/monitor_db/monitor_db_event.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';
import 'package:walletter/model/transactionModel.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _firestoreSubscription;

  List<TransactionForm> firestoreTransactionList;
  List<String> firestoreIdList;
  Map<dynamic, dynamic> firestoreUserInfo;

  MonitorBloc() : super(MonitorState(transactionList: [], idList: [])) {
    add(AskNewList());

    _firestoreSubscription =
        FirestoreRemoteServer.helper.stream.listen((response) {
      try {
        firestoreTransactionList = response[0];
        firestoreIdList = response[1];
        add(
          UpdateList(
            transactionList: firestoreTransactionList,
            idList: firestoreIdList,
          ),
        );
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      // Ir ao Firebase pedir novos dados
      var firestoreResponse =
          await FirestoreRemoteServer.helper.getTransactionList();

      // response remote
      firestoreTransactionList = firestoreResponse[0];
      firestoreIdList = firestoreResponse[1];

      yield MonitorState(
        transactionList: firestoreTransactionList,
        idList: firestoreIdList,
      );
    } else if (event is UpdateList) {
      yield MonitorState(
        idList: event.idList,
        transactionList: event.transactionList,
      );
    }
  }

  close() {
    _firestoreSubscription.cancel();
    return super.close();
  }
}
