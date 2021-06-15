import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/data/firestore_database.dart';
import 'package:walletter/logic/manage_auth/auth_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_event.dart';
import 'package:walletter/logic/monitor_db/monitor_db_bloc.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(
      builder: (context, state) {
        return FutureBuilder<DocumentSnapshot>(
          future: FirestoreRemoteServer.helper.getUserInformation(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> userData =
                  snapshot.data.data() as Map<String, dynamic>;
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      logoWalletter(),
                      Divider(
                        height: 70,
                        endIndent: 100,
                        indent: 100,
                      ),
                      userName(userData),
                      Divider(
                        height: 70,
                        endIndent: 100,
                        indent: 100,
                      ),
                      userInformations(userData)
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.greenAccent.shade700,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget userInformations(Map<dynamic, dynamic> userData) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.email_rounded),
              SizedBox(width: 15),
              Text(
                "${userData['email']}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.calendar_today_rounded),
              SizedBox(width: 15),
              Text(
                "${(userData['idade']).round()} anos",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.credit_card_rounded),
              SizedBox(width: 15),
              if (userData['creditCard'])
                Text("Possui crédito", style: TextStyle(fontSize: 18)),
              if (!userData['creditCard'])
                Text("Não possui crédito", style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.people_alt_rounded),
              SizedBox(width: 15),
              if (userData['dependents'])
                Text("Possui dependentes", style: TextStyle(fontSize: 18)),
              if (!userData['dependents'])
                Text("Não possui dependentes", style: TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  Widget logoWalletter() {
    return Column(children: [
      Image.asset(
        'assets/images/money_logo.png',
        width: 120,
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "Walletter",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    ]);
  }

  Widget logoutButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Navigator.pushReplacementNamed(context, '/');
        BlocProvider.of<AuthBloc>(context).add(Logout());
      },
      style: ElevatedButton.styleFrom(
        elevation: 10,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        primary: Colors.grey.shade300,
      ),
      label: Text(
        "Logout",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      icon: Icon(
        Icons.logout_outlined,
        color: Colors.black,
      ),
    );
  }

  Widget userName(Map<dynamic, dynamic> userData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${userData['fullName']}",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        if (userData['rendaMensal'] == 1)
          Text(
            "Menos que R\$ 1.000,00",
            style: TextStyle(
                color: Colors.white38,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        if (userData['rendaMensal'] == 2)
          Text(
            "R\$ 1.000,00 ~ R\$ 2.500,00",
            style: TextStyle(
                color: Colors.white38,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        if (userData['rendaMensal'] == 3)
          Text(
            "R\$ 2.500,00 ~ R\$ 5.000,00",
            style: TextStyle(
                color: Colors.white38,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        if (userData['rendaMensal'] == 4)
          Text(
            "R\$ 5.000,00 ~ R\$ 10.000,00",
            style: TextStyle(
                color: Colors.white38,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        if (userData['rendaMensal'] == 5)
          Text(
            "Mais que R\$ 10.000,00",
            style: TextStyle(
                color: Colors.white38,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}
