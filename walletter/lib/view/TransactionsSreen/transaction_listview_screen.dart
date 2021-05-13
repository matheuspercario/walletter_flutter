import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';
import 'package:walletter/logic/monitor_db/monitor_local_db_bloc.dart';

class TransactionsListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransactionsListViewState();
  }
}

class _TransactionsListViewState extends State<TransactionsListView> {
  final Map translate = {
    'expense': 0,
    'income': 1,
  };

  final List colors = [
    Colors.redAccent.shade700,
    Colors.greenAccent.shade700,
  ];

  final List icons = [
    Icons.remove_circle_outlined,
    Icons.add_circle_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) {
      return getTransactionListView(state.transactionList, state.idList);
    });
  }

  Widget getTransactionListView(transactionList, idList) {
    return ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, position) {
          return Tooltip(
            message: 'Deslize para deletar',
            child: Dismissible(
              key: ValueKey(123),
              direction: DismissDirection.startToEnd,
              confirmDismiss: (direction) async {
                await showDialog(
                  context: context,
                  builder: (_) => generateConfirmationDialog(),
                  barrierDismissible: false,
                );
              },
              background: Container(
                color: Colors.redAccent.shade400,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                margin: EdgeInsets.only(bottom: 5, top: 5),
              ),
              child: listviewCard(transactionList, position),
            ),
          );
        });
  }

  Card listviewCard(transactionList, position) {
    // print(transactionList[position].category);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 7,
      child: ListTile(
        title: Text(transactionList[position].description),
        subtitle: Text(transactionList[position].date),
        leading: Icon(
          icons[1],
          //color: colors[translate[transactionList[position].category]],
        ),
        trailing: Text(transactionList[position].value),
      ),
    );
  }

  Widget generateConfirmationDialog() {
    return AlertDialog(
      title: Text(
        "Confirme para prosseguir",
        style: TextStyle(color: Colors.black87),
      ),
      content: Text("Você tem certeza de que deseja apagar a transação?",
          style: TextStyle(color: Colors.black87)),
      actions: [
        TextButton(
          child: Text("Sim"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Não"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      backgroundColor: Colors.grey.shade100,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
