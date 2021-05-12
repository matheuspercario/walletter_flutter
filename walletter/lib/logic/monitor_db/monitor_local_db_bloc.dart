import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:walletter/data/local_database.dart';
import 'package:walletter/logic/monitor_db/monitor_db_event.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';
import 'package:walletter/model/transactionModel.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _localSubscription;
  MonitorBloc() : super(MonitorState(transactionList: [], idList: [])) {
    add(AskNewList());
    _localSubscription = DatabaseLocalServer.helper.stream.listen((response) {
      try {
        List<TransactionForm> localTransactionList = response[0];
        List<int> localIdList = response[1];
        add(
          UpdateList(
            transactionList: localTransactionList,
            idList: localIdList,
          ),
        );
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      // Ir ao BD
      var response = await DatabaseLocalServer.helper.getTransactionList();
      List<TransactionForm> localNoteList = response[0];
      List<int> localIdList = response[1];
      yield MonitorState(idList: localIdList, transactionList: localNoteList);
    } else if (event is UpdateList) {
      yield MonitorState(
        idList: event.idList,
        transactionList: event.transactionList,
      );
    }
  }

  close() {
    _localSubscription.cancel();
    return super.close();
  }
}
