import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_state.dart';
import 'package:walletter/view/auth/login.dart';
import 'package:walletter/view/auth/register.dart';
import 'package:walletter/view/my_app/TransactionsSreen/add_expense_screen.dart';
import 'package:walletter/view/my_app/TransactionsSreen/add_income_screen.dart';
import 'package:walletter/view/my_app/bottom_navigation.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is Authenticated) {
          return MyApp();
        } else {
          return AuthPages();
        }
      },
      listener: (context, state) {
        if (state is AuthError) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Erro do Servidor"),
                content: Text("${state.message}"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}

class AuthPages extends StatelessWidget {
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
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
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
