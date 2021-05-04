import 'package:flutter/material.dart';

class TransactionsListView extends StatefulWidget {
  TransactionsListView({Key key}) : super(key: key);

  @override
  _TransactionsStateListView createState() => _TransactionsStateListView();
}

class _TransactionsStateListView extends State<TransactionsListView> {
  final List icons = [
    Icons.remove_circle_outlined,
    Icons.add_circle_rounded,
  ];
  final List texto = [
    "Compra na padaria",
    "Pensão do meu pai",
    "Gasolina da moto",
    "Jogo da Steam",
    "Presente da minha avó",
    "Salário Estágio",
    "Sorvetes",
  ];

  final List colors = [
    Colors.redAccent.shade700,
    Colors.greenAccent.shade700,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: efficientlyGenerateListView(),
    );
  }

  Widget efficientlyGenerateListView() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Tooltip(
            message: 'Deslize para deletar',
            child: Dismissible(
              key: ValueKey(123),
              direction: DismissDirection.startToEnd,
              // onDismissed: (direction) async {
              //   //print(direction);
              //   await showDialog(
              //     context: context,
              //     builder: (_) => generateConfirmationDialog(),
              //     barrierDismissible: false,
              //   );
              // },
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
              child: listviewCard(index),
            ),
          );
        });
  }

  Card listviewCard(int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 7,
      child: ListTile(
        title: Text(
          texto[index % texto.length],
        ),
        leading: Icon(
          icons[index % icons.length],
          color: colors[index % colors.length],
        ),
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
