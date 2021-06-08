class LoginForm {
  String email;
  String password;
  bool confirmed = false;

  doSomething() {
    print("Username: $email");
    print("Password: $password");
  }
}
