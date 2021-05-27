import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/data/remote_database.dart';
import 'package:walletter/logic/manage_db/manage_db_event.dart';
import 'package:walletter/logic/manage_db/manage_db_state.dart';

class ManageRemoteBloc extends Bloc<ManageEvent, ManageState> {
  ManageRemoteBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    if (event is DeleteEvent) {
      DatabaseRemoteServer.helper.deleteTransaction(event.transactionId);
    } else if (event is SubmitEvent) {
      DatabaseRemoteServer.helper.insertTransaction(event.transaction);
    }
  }
}
