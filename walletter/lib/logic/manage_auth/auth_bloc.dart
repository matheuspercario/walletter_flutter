import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:walletter/auth_provider/firebase_auth.dart';
import 'package:walletter/data/firestore_database.dart';
import 'package:walletter/logic/manage_auth/auth_event.dart';
import 'package:walletter/logic/manage_auth/auth_state.dart';
import 'package:walletter/model/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuthenticationService _authenticationService;
  // ignore: unused_field
  StreamSubscription _authenticationStream;

  AuthBloc() : super(Unauthenticated()) {
    _authenticationService = FirebaseAuthenticationService();
    _authenticationStream = _authenticationService.user.listen(
      (UserModel userModel) {
        add(InnerServerEvent(userModel));
      },
    );
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event == null) {
        yield Unauthenticated();
      } else if (event is RegisterUser) {
        await _authenticationService.createUserWithEmailAndPassword(
          fullName: event.fullName,
          email: event.email,
          password: event.password,
          dependents: event.switchDependents,
          creditCard: event.switchCreditCard,
          idade: event.sliderValue,
          rendaMensal: event.radioValue,
          hasCasa: event.checkBoxCasa,
          hasCarro: event.checkBoxCarro,
          hasMoto: event.checkBoxMoto,
          hasBicicleta: event.checkBoxBicicleta,
        );
      } else if (event is LoginUser) {
        await _authenticationService.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
      } else if (event is InnerServerEvent) {
        if (event.userModel == null) {
          yield Unauthenticated();
        } else {
          FirestoreRemoteServer.uid = event.userModel.uid;
          yield Authenticated(user: event.userModel);
        }
      } else if (event is Logout) {
        await _authenticationService.signOut();
      }
    } catch (e) {
      yield AuthError(message: e.toString());
    }
  }
}
