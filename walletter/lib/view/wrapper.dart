import 'package:flutter/material.dart';
import 'package:walletter/view/auth/login.dart';
import 'package:walletter/view/my_app_screen/TransactionsSreen/add_expense_screen.dart';
import 'package:walletter/view/my_app_screen/TransactionsSreen/add_income_screen.dart';
import 'package:walletter/view/my_app_screen/my_app_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return MyApp();
    return LoginPage();
  }
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
        textTheme: TextTheme(),
        accentColor: Colors.white,
      ),
      routes: {
        '/': (context) => MyBottomNavigationBar(),
        '/add_income': (context) => AddIncome(),
        '/add_expense': (context) => AddExpense(),
      },
    ); // Gerenciador de Estados Automático
  }
}
