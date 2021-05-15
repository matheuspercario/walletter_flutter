import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_db/manage_db_event.dart';
import 'package:walletter/logic/manage_db/manage_db_state.dart';
import 'package:walletter/logic/manage_db/manage_local_db_bloc.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:walletter/model/transactionModel.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final GlobalKey<FormState> formKeyIncome = new GlobalKey<FormState>();

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ManageLocalBloc(),
      child: Scaffold(
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
                  child: myIncomeForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myIncomeForm() {
    return BlocBuilder<ManageLocalBloc, ManageState>(builder: (context, state) {
      TransactionForm expenseForm;
      expenseForm = new TransactionForm();

      return Form(
        key: formKeyIncome,
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            valueInputForm(expenseForm),
            SizedBox(
              height: 70,
            ),
            valueDateForm(expenseForm),
            SizedBox(
              height: 20,
            ),
            valueDescriptionForm(expenseForm),
            SizedBox(
              height: 100,
            ),
            submitInformations(expenseForm, context),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    });
  }

  Widget valueDateForm(TransactionForm expenseForm) {
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
            print("Don't picked any date...");
          } else {
            setState(() {
              _dateTime = picked;
            });
          }
        });
      },
      onSaved: (_) {
        expenseForm.date =
            DateFormat("dd/MM/yyyy hh:mm").format(_dateTime).toString();
      },
    );
  }

  Widget valueDescriptionForm(TransactionForm expenseForm) {
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

  Widget valueInputForm(TransactionForm expenseForm) {
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

  Widget submitInformations(TransactionForm expenseForm, context) {
    return ElevatedButton(
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
      onPressed: () {
        if (formKeyIncome.currentState.validate()) {
          formKeyIncome.currentState.save();
          expenseForm.category = "expense";
          expenseForm.doSomething();
          BlocProvider.of<ManageLocalBloc>(context)
              .add(SubmitEvent(transaction: expenseForm));
          Navigator.pop(context);
          // Navigator.pushReplacementNamed(context, '/homepage');
        }
      },
    );
  }
}
