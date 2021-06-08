class TransactionForm {
  String _value;
  String _date;
  String _description;
  String _category;

  TransactionForm() {
    _value = "";
    _date = "";
    _description = "";
    _category = "";
  }

  TransactionForm.fromMap(map) {
    this._value = map["value"];
    this._date = map["date"];
    this._description = map["description"];
    this._category = map["category"];
  }

  String get value => _value;
  String get date => _date;
  String get description => _description;
  String get category => _category;

  set value(String newValue) {
    if (newValue.length > 0) {
      this._value = newValue;
    }
  }

  set date(String newDate) {
    if (newDate.length > 0) {
      this._date = newDate;
    }
  }

  set description(String newDescription) {
    if (newDescription.length > 0) {
      this._description = newDescription;
    }
  }

  set category(String newCategory) {
    if (newCategory.length > 0) {
      this._category = newCategory;
    }
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["value"] = _value;
    map["date"] = _date;
    map["description"] = _description;
    map["category"] = _category;
    return map;
  }

  doSomething() {
    print("Valor: $value");
    print("Date: $date");
    print("Description: $description");
    print("Tipo: $category");
  }
}
