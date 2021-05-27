import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:walletter/data/remote_database.dart';
import 'package:walletter/logic/monitor_db/monitor_db_event.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';
import 'package:walletter/model/transactionModel.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _remoteSubscription;

  List<TransactionForm> remoteTransactionList;
  List<int> remoteIdList;

  MonitorBloc() : super(MonitorState(transactionList: [], idList: [])) {
    add(AskNewList());

    _remoteSubscription = DatabaseRemoteServer.helper.stream.listen((response) {
      try {
        remoteTransactionList = response[0];
        remoteIdList = response[1];
        add(
          UpdateList(
            transactionList: remoteTransactionList,
            idList: remoteIdList,
          ),
        );
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      // Ir ao Servidor pedir novos dados
      var remoteResponse =
          await DatabaseRemoteServer.helper.getTransactionList();

      // response remote
      remoteTransactionList = remoteResponse[0];
      remoteIdList = remoteResponse[1];

      yield MonitorState(
        transactionList: remoteTransactionList,
        idList: remoteIdList,
      );
    } else if (event is UpdateList) {
      yield MonitorState(
        idList: event.idList,
        transactionList: event.transactionList,
      );
    }
  }

  close() {
    _remoteSubscription.cancel();
    return super.close();
  }
}
