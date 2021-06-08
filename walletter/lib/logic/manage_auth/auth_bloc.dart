import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:walletter/auth_provider/firebase_auth.dart';
import 'package:walletter/logic/manage_auth/auth_event.dart';
import 'package:walletter/logic/manage_auth/auth_state.dart';
import 'package:walletter/model/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  StreamSubscription _authenticationStream;
  FirebaseAuthenticationService _authenticationService;

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
          has_Casa: event.checkBoxCasa,
          has_Carro: event.checkBoxCarro,
          has_Moto: event.checkBoxMoto,
          has_Bicicleta: event.checkBoxBicicleta,
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
