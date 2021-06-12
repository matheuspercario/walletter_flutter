import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_db/manage_db_event.dart';
import 'package:walletter/logic/manage_db/manage_firestore_db_bloc.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';
import 'package:walletter/logic/monitor_db/monitor_db_bloc.dart';

class TransactionsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransactionsListState();
  }
}

class _TransactionsListState extends State<TransactionsList> {
  final Map translateCategory = {
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
      return getTransactionList(state.transactionList, state.idList);
    });
  }

  Widget getTransactionList(transactionList, idList) {
    return ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, position) {
          return Tooltip(
            message: 'Deslize para deletar',
            child: Dismissible(
              key: ValueKey(123),
              direction: DismissDirection.startToEnd,
              // ignore: missing_return
              confirmDismiss: (direction) async {
                await showDialog(
                  context: context,
                  builder: (_) => generateConfirmationDialog(
                    transactionList,
                    idList,
                    position,
                  ),
                  barrierDismissible: false,
                  useRootNavigator: false,
                );
                //return true;
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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 7,
      child: ListTile(
        title: Text(transactionList[position].description),
        subtitle: Text(transactionList[position].date),
        leading: Icon(
          icons[translateCategory[transactionList[position].category]],
          color: colors[translateCategory[transactionList[position].category]],
        ),
        trailing: Text(
          "R\$ ${transactionList[position].value}",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colors[
                  translateCategory[transactionList[position].category]]),
        ),
      ),
    );
  }

  Widget generateConfirmationDialog(transactionList, idList, position) {
    return AlertDialog(
      title: Text(
        "Confirme para prosseguir",
      ),
      content: Text(
        "Você tem certeza de que deseja apagar a transação?",
      ),
      actions: [
        TextButton(
          child: Text("Sim", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            primary: Colors.greenAccent.shade400,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            BlocProvider.of<ManageFirestoreBloc>(context).add(
              DeleteEvent(
                transactionId: idList[position],
              ),
            );
          },
        ),
        TextButton(
          child: Text("Não", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            primary: Colors.redAccent.shade400,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
