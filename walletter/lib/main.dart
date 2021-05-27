import 'package:flutter/material.dart';
import 'package:walletter/view/TransactionsSreen/add_expense_screen.dart';
import 'package:walletter/view/TransactionsSreen/add_income_screen.dart';
import 'package:walletter/view/login/login.dart';
import 'package:walletter/view/bottom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Walletter',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        //primaryColor: Colors.greenAccent[700],
        textTheme: TextTheme(),
        accentColor: Colors.white,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/homepage': (context) => MyBottomNavigationBar(),
        '/add_income': (context) => AddIncome(),
        '/add_expense': (context) => AddExpense(),
      },
    ); // Gerenciador de Estados Automático
  }
}
