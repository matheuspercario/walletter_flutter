import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:walletter/data/local/local_database.dart';
import 'package:walletter/data/remote/remote_database.dart';
import 'package:walletter/logic/monitor_db/monitor_db_event.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';
import 'package:walletter/model/transactionModel.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _localSubscription;
  StreamSubscription _remoteSubscription;

  List<TransactionForm> localTransactionList;
  List<TransactionForm> remoteTransactionList;
  List<int> localIdList;
  List<int> remoteIdList;

  MonitorBloc() : super(MonitorState(transactionList: [], idList: [])) {
    add(AskNewList());

    _localSubscription = DatabaseLocalServer.helper.stream.listen((response) {
      try {
        localTransactionList = response[0];
        localIdList = response[1];
        add(
          UpdateList(
            transactionList: List.from(localTransactionList)
              ..addAll(remoteTransactionList),
            idList: List.from(localIdList)..addAll(remoteIdList),
          ),
        );
      } catch (e) {}
    });

    _remoteSubscription = DatabaseRemoteServer.helper.stream.listen((response) {
      try {
        remoteTransactionList = response[0];
        remoteIdList = response[1];
        add(
          UpdateList(
            transactionList: List.from(localTransactionList)
              ..addAll(remoteTransactionList),
            idList: List.from(localIdList)..addAll(remoteIdList),
          ),
        );
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      // Ir ao BD Local pedir novos dados
      var localResponse = await DatabaseLocalServer.helper.getTransactionList();
      // Ir ao Servidor pedir novos dados
      var remoteResponse =
          await DatabaseRemoteServer.helper.getTransactionList();

      // response local
      localTransactionList = localResponse[0];
      localIdList = localResponse[1];

      // response remote
      remoteTransactionList = remoteResponse[0];
      remoteIdList = remoteResponse[1];

      yield MonitorState(
        transactionList: List.from(localTransactionList)
          ..addAll(remoteTransactionList),
        idList: List.from(localIdList)..addAll(remoteIdList),
      );
    } else if (event is UpdateList) {
      yield MonitorState(
        idList: event.idList,
        transactionList: event.transactionList,
      );
    }
  }

  close() {
    _localSubscription.cancel();
    _remoteSubscription.cancel();
    return super.close();
  }
}
