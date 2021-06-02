import 'package:flutter/material.dart';
import 'package:walletter/model/addTransactionModel.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  AddExpense({Key key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final GlobalKey<FormState> formKeyExpense = new GlobalKey<FormState>();
  final AddExpenseForm expenseForm = new AddExpenseForm();

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova Despesa',
        ),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 50, left: 50),
                child: myexpenseForm(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myexpenseForm() {
    return Form(
      key: formKeyExpense,
      child: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          valueInputForm(),
          SizedBox(
            height: 70,
          ),
          valueDateForm(),
          SizedBox(
            height: 20,
          ),
          valueDescriptionForm(),
          SizedBox(
            height: 100,
          ),
          submitInformations(),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget valueDateForm() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: DateFormat("dd/MM/yyyy").format(_dateTime).toString(),
        icon: Icon(Icons.calendar_today_rounded),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now().add(const Duration(days: 100)),
        ).then((picked) {
          if (picked == null) {
            print("Don't piked any date...");
          } else {
            setState(() {
              _dateTime = picked;
            });
          }
        });
      },
      onSaved: (_) {
        expenseForm.date = _dateTime;
      },
    );
  }

  Widget valueDescriptionForm() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        icon: Icon(Icons.edit),
        labelText: "Descrição",
      ),
      validator: (String inValue) {
        if (inValue.length < 0) {
          return "Descrição";
        }
        if (inValue.length == 0) {
          return null;
        }
        return null;
      },
      onSaved: (String inValue) {
        expenseForm.description = inValue;
      },
    );
  }

  Widget valueInputForm() {
    return TextFormField(
      style: TextStyle(fontSize: 32),
      inputFormatters: [
        CurrencyTextInputFormatter(
          decimalDigits: 2,
          symbol: 'R\$ ',
        )
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "R\$ 0.00",
        // labelText: "Insira o valor",
        suffixIcon: Icon(
          Icons.remove_circle_rounded,
          color: Colors.redAccent.shade700,
        ),
      ),
      validator: (String inValue) {
        if (inValue.isEmpty) {
          return "Insira um valor";
        }
        return null;
      },
      onSaved: (String inValue) {
        expenseForm.value = inValue;
      },
    );
  }

  Widget submitInformations() {
    return ElevatedButton(
      onPressed: () {
        if (formKeyExpense.currentState.validate()) {
          formKeyExpense.currentState.save();
          expenseForm.doSomething();
          // Navigator.pushReplacementNamed(context, '/homepage');
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: Colors.redAccent.shade400,
        shape: CircleBorder(),
      ),
    );
  }
}
