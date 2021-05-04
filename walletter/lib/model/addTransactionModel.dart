class AddIncomeForm {
  var value;
  var date;
  var description;
  var confirmed = false;
  var type = "income";

  doSomething() {
    print("Valor: $value");
    print("Date: $date");
    print("Description: $description");
    print("Tipo: $type");
  }
}

class AddExpenseForm {
  var value;
  var date;
  var description;
  var confirmed = false;
  var type = "expense";

  doSomething() {
    print("Valor: $value");
    print("Date: $date");
    print("Description: $description");
    print("Tipo: $type");
  }
}
