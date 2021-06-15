import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/data/firestore_database.dart';
import 'package:walletter/logic/monitor_db/monitor_db_bloc.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.greenAccent.shade700,
              ),
              Positioned(
                top: 120,
                child: myCard(),
              ),
              Image.asset(
                'assets/images/money_logo.png',
                fit: BoxFit.contain,
                height: 75,
              ),
            ],
          ),
          Container(
            //decoration: BoxDecoration(color: Colors.amber),
            padding: EdgeInsets.only(top: 170),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                addIncome(),
                addExpense(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addIncome() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/add_income');
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: Colors.greenAccent.shade700,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(50),
        ),
      ),
    );
  }

  Widget addExpense() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/add_expense');
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
          Icons.remove_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: Colors.redAccent.shade700,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(50),
        ),
      ),
    );
  }

  Card myCard() {
    return Card(
      color: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 10,
      child: Container(
        width: 350,
        height: 200,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: Text(
                  "Saldo",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            BlocBuilder<MonitorBloc, MonitorState>(
              builder: (context, state) {
                return FutureBuilder<dynamic>(
                  future: FirestoreRemoteServer.helper.getCurrentMoney(),
                  builder: (context, currentMoney) {
                    final currencyFormatter = NumberFormat.currency(
                      locale: 'pt_BR',
                      customPattern: "#,##0.00",
                    );
                    if (currentMoney.connectionState == ConnectionState.done) {
                      return Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.monetization_on_rounded,
                                color: (currentMoney.data >= 0)
                                    ? Colors.green
                                    : Colors.red,
                                size: 40.0,
                              ),
                              Text("         "),
                              Text(
                                "${currencyFormatter.format(currentMoney.data)}",
                                style: TextStyle(
                                    color: (currentMoney.data >= 0)
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator(
                        color: Colors.greenAccent.shade700,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
