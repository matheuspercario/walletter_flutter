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
    } else if (event is SubmitEvent) {
      FirestoreRemoteServer.helper.insertTransaction(event.transaction);
    }
  }
}
