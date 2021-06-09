class TransactionForm {
  var _value;
  var _date;
  var _description;
  var _category;

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

  dynamic get value => _value;
  dynamic get date => _date;
  dynamic get description => _description;
  dynamic get category => _category;

  set value(var newValue) {
    if (newValue.length > 0) {
      this._value = newValue;
    }
  }

  set date(var newDate) {
    if (newDate.length > 0) {
      this._date = newDate;
    }
  }

  set description(var newDescription) {
    if (newDescription.length > 0) {
      this._description = newDescription;
    }
  }

  set category(var newCategory) {
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
