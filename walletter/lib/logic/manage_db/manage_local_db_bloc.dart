import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/data/local_database.dart';
import 'package:walletter/logic/manage_db/manage_db_event.dart';
import 'package:walletter/logic/manage_db/manage_db_state.dart';

class ManageLocalBloc extends Bloc<ManageEvent, ManageState> {
  ManageLocalBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    if (event is DeleteEvent) {
      DatabaseLocalServer.helper.deleteTransaction(event.transactionId);
    } else if (event is SubmitEvent) {
      DatabaseLocalServer.helper.insertTransaction(event.transaction);
    }
  }
}
