import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_event.dart';
import 'package:walletter/logic/monitor_db/monitor_db_bloc.dart';
import 'package:walletter/logic/monitor_db/monitor_db_state.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            logoutButton(context),
            SizedBox(
              height: 30,
            ),
            userName(),
            Divider(
              height: 70,
              endIndent: 100,
              indent: 100,
            ),
            userInformations()
          ],
        ),
      ),
    );
  }

  Widget userInformations() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informações",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Nome: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Matheus Bruder"),
            ],
          ),
          Row(
            children: [
              Text(
                "Idade: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("22"),
            ],
          ),
          Row(
            children: [
              Text(
                "Email: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("mpbruder@gmail.com"),
            ],
          ),
          Row(
            children: [
              Text(
                "Dependentes: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Não"),
            ],
          ),
          Row(
            children: [
              Text(
                "Cartão de crédito: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Sim"),
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

  Widget userName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "User: ",
          style: TextStyle(fontSize: 16),
        ),
        BlocBuilder<MonitorBloc, MonitorState>(
          builder: (context, state) {
            return Text(
              "oi",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ],
    );
  }
}
