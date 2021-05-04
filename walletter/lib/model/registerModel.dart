class RegisterForm {
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

  doSomething() {
    print("String   -> Nome completo: $fullName");
    print("String   -> Nome senha: $password");
    print("String   -> Nome email: $email");
    print("Radio    -> Renda mensal: $radioValue");
    print("Switch   -> Dependentes: $switchDependents");
    print("Switch   -> Cartão de crédito: $switchCreditCard");
    print("CheckBox -> Casa: $checkBoxCasa");
    print("CheckBox -> Carro: $checkBoxCarro");
    print("CheckBox -> Moto: $checkBoxMoto");
    print("CheckBox -> Bibicleta: $checkBoxBicicleta");
  }
}
