import 'package:walletter/model/user.dart';

abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  String fullName;
  String email;
  String password;
  var switchDependents = false;
  var switchCreditCard = false;
  var sliderValue = 18.0;
  var radioValue = 1;
  var checkBoxCasa = false;
  var checkBoxCarro = false;
  var checkBoxMoto = false;
  var checkBoxBicicleta = false;
  bool confirmed = false;
}

class LoginUser extends AuthEvent {
  String email;
  String password;
}

class Logout extends AuthEvent {}

class InnerServerEvent extends AuthEvent {
  final UserModel userModel;
  InnerServerEvent(this.userModel);
}
