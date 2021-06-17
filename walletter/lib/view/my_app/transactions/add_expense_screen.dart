import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_db/manage_db_event.dart';
import 'package:walletter/logic/manage_db/manage_db_state.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:walletter/logic/manage_db/manage_firestore_db_bloc.dart';
import 'package:walletter/model/transactionModel.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final GlobalKey<FormState> formKeyExpense = new GlobalKey<FormState>();

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ManageFirestoreBloc, ManageState>(
          builder: (context, state) {
            return Text(
                state is InsertState ? 'Nova Despesa' : "Atualizar Despesa");
          },
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
    );
  }

  Widget myIncomeForm() {
    return BlocBuilder<ManageFirestoreBloc, ManageState>(
      builder: (context, state) {
        TransactionForm expenseForm;
        if (state is UpdateState) {
          expenseForm = state.previousTransaction;
          _dateTime =
              DateFormat("dd/MM/yyyy").parse(state.previousTransaction.date);
        } else {
          expenseForm = new TransactionForm();
        }

        return Form(
          key: formKeyExpense,
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              valueInputForm(expenseForm, state),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  submitButton(expenseForm, context),
                  state is UpdateState
                      ? cancelButton(state, context)
                      : Container()
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget valueDateForm(TransactionForm expenseForm) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: DateFormat("dd/MM/yyyy").format(_dateTime).toString(),
        icon: Icon(Icons.calendar_today_rounded),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime.now().add(const Duration(days: 100)),
          // ignore: missing_return
        ).then((picked) async {
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
            DateFormat("dd/MM/yyyy").format(_dateTime).toString();
      },
    );
  }

  Widget valueDescriptionForm(TransactionForm expenseForm) {
    return TextFormField(
      initialValue: expenseForm.description,
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
        if (expenseForm.description == "") {
          expenseForm.description = "Sem descrição";
        }
        expenseForm.description = inValue.trim();
      },
    );
  }

  Widget valueInputForm(TransactionForm expenseForm, state) {
    return TextFormField(
      initialValue: expenseForm.value,
      style: TextStyle(fontSize: 32),
      inputFormatters: [
        CurrencyTextInputFormatter(
          decimalDigits: 2,
          symbol: 'R\$ ',
        )
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText:
            state is UpdateState ? "R\$ ${expenseForm.value}" : "R\$ 0.00",
        // labelText: "Insira o valor",
        suffixIcon: Icon(
          Icons.remove_circle_rounded,
          color: Colors.redAccent.shade700,
        ),
      ),
      validator: (var inValue) {
        if (inValue.isEmpty) {
          return "Insira um valor";
        }
        return null;
      },
      onSaved: (var inValue) {
        expenseForm.value = inValue.split(" ")[1].replaceAll(",", "");
      },
    );
  }

  Widget submitButton(TransactionForm expenseForm, context) {
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
        if (formKeyExpense.currentState.validate()) {
          formKeyExpense.currentState.save();
          expenseForm.category = "expense";
          expenseForm.doSomething();
          BlocProvider.of<ManageFirestoreBloc>(context)
              .add(SubmitEvent(transaction: expenseForm));
          Navigator.pop(context);
        }
      },
    );
  }

  Widget cancelButton(state, context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
          Icons.remove_done_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: Colors.grey.shade600,
        shape: CircleBorder(),
      ),
      onPressed: () {
        BlocProvider.of<ManageFirestoreBloc>(context).add(UpdateCancel());
        Navigator.pop(context);
      },
    );
  }
}
