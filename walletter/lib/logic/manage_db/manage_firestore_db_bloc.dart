import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/data/firestore_database.dart';
import 'package:walletter/logic/manage_db/manage_db_event.dart';
import 'package:walletter/logic/manage_db/manage_db_state.dart';

class ManageFirestoreBloc extends Bloc<ManageEvent, ManageState> {
  ManageFirestoreBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    if (event is DeleteEvent) {
      FirestoreRemoteServer.helper.deleteTransaction(event.transactionId);
      yield InsertState();
    } else if (event is UpdateRequest) {
      yield UpdateState(
        transactionId: event.transactionId,
        previousTransaction: event.previousTransaction,
      );
    } else if (event is UpdateCancel) {
      yield InsertState();
    } else if (event is SubmitEvent) {
      if (state is InsertState) {
        FirestoreRemoteServer.helper.insertTransaction(event.transaction);
      } else if (state is UpdateState) {
        UpdateState updateState = state;
        FirestoreRemoteServer.helper.updateTransaction(updateState.transactionId, event.transaction);
        yield InsertState();
      }
    }
  }
}
