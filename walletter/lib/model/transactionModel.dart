class TransactionForm {
  String _value;
  String _date;
  String _description;
  String _type;
  // var _confirmed = false;

  TransactionForm() {
    _value = "";
    _date = "";
    _description = "";
    _type = "";
  }

  TransactionForm.fromMap(map) {
    this._value = map["value"];
    this._date = map["date"];
    this._description = map["description"];
    this._type = map["type"];
  }

  String get value => _value;
  String get date => _date;
  String get description => _description;
  String get type => _type;

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

  set type(String newType) {
    if (newType.length > 0) {
      this._type = newType;
    }
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["title"] = _value;
    map["date"] = _date;
    map["description"] = _description;
    map["type"] = _type;
    return map;
  }

  doSomething() {
    print("Valor: $value");
    print("Date: $date");
    print("Description: $description");
    print("Tipo: $type");
  }
}
