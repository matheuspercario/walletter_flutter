import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:walletter/data/firestore_database.dart';

import 'package:walletter/logic/monitor_db/monitor_db_event.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';
import 'package:walletter/model/transactionModel.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _firestoreSubscription;

  List<TransactionForm> firestoreTransactionList;
  List<int> firestoreIdList;

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
      var remoteResponse =
          await FirestoreRemoteServer.helper.getTransactionList();

      // response remote
      firestoreTransactionList = remoteResponse[0];
      firestoreIdList = remoteResponse[1];

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
