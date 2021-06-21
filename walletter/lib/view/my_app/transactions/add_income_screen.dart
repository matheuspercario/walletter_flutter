import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_db/manage_db_event.dart';
import 'package:walletter/logic/manage_db/manage_db_state.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:walletter/logic/manage_db/manage_firestore_db_bloc.dart';
import 'package:walletter/model/transactionModel.dart';

class AddIncome extends StatefulWidget {
  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final GlobalKey<FormState> formKeyIncome = new GlobalKey<FormState>();

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ManageFirestoreBloc, ManageState>(
          builder: (context, state) {
            return Text(
                state is InsertState ? 'Nova Receita' : "Atualizar Receita");
          },
        ),
        backgroundColor: Colors.greenAccent.shade700,
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
        TransactionForm incomeForm;
        if (state is UpdateState) {
          incomeForm = state.previousTransaction;
          _dateTime =
              DateFormat("dd/MM/yyyy").parse(state.previousTransaction.date);
        } else {
          incomeForm = new TransactionForm();
        }

        return Form(
          key: formKeyIncome,
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              valueInputForm(incomeForm, state),
              SizedBox(
                height: 70,
              ),
              valueDateForm(incomeForm),
              SizedBox(
                height: 20,
              ),
              valueDescriptionForm(incomeForm),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  submitButton(incomeForm, context),
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

  Widget valueDateForm(TransactionForm incomeForm) {
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
          lastDate: DateTime.now().add(const Duration(days: 1000)),
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
        incomeForm.date = DateFormat("dd/MM/yyyy").format(_dateTime).toString();
      },
    );
  }

  Widget valueDescriptionForm(TransactionForm incomeForm) {
    return TextFormField(
      initialValue: incomeForm.description,
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
        if (incomeForm.description == "") {
          incomeForm.description = "Sem descrição";
        }
        incomeForm.description = inValue.trim();
      },
    );
  }

  Widget valueInputForm(TransactionForm incomeForm, state) {
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
        hintText: state is UpdateState ? "R\$ ${incomeForm.value}" : "R\$ 0.00",
        // labelText: "Insira o valor",
        suffixIcon: Icon(
          Icons.add_circle_rounded,
          color: Colors.greenAccent.shade700,
        ),
      ),
      validator: (String inValue) {
        if (inValue.isEmpty) {
          return "Insira um valor";
        }
        return null;
      },
      onSaved: (var inValue) {
        incomeForm.value = inValue.split(" ")[1].replaceAll(",", "");
      },
    );
  }

  Widget submitButton(TransactionForm incomeForm, context) {
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
        primary: Colors.greenAccent.shade400,
        shape: CircleBorder(),
      ),
      onPressed: () {
        if (formKeyIncome.currentState.validate()) {
          formKeyIncome.currentState.save();
          incomeForm.category = "income";
          incomeForm.doSomething();
          BlocProvider.of<ManageFirestoreBloc>(context)
              .add(SubmitEvent(transaction: incomeForm));
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
