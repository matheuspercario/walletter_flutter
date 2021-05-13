import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_db/manage_local_db_bloc.dart';
import 'package:walletter/logic/monitor_db/monitor_local_db_bloc.dart';

import 'HomeScreen/home_screen.dart';
import 'TransactionsSreen/transaction_listview_screen.dart';
import 'UserScreen/user_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 1;
  List<Widget> _pages = [
    TransactionsListView(),
    HomeScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MonitorBloc()),
        BlocProvider(create: (_) => ManageLocalBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Walletter',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.greenAccent.shade700,
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 1.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: kBottomNavigationBarHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: 0.1,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Colors.grey.shade900,
                selectedItemColor: Colors.white,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list_sharp), label: 'Transações'),
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Perfil')
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: _currentIndex == 1
                ? Colors.grey.shade300
                : Colors.grey.shade900,
            child: Icon(Icons.home),
            onPressed: () => setState(() {
              _currentIndex = 1;
            }),
          ),
        ),
      ),
    );
  }
}
