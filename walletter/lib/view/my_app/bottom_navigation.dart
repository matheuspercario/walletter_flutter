import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_event.dart';
import 'package:walletter/logic/manage_db/manage_firestore_db_bloc.dart';
import 'package:walletter/logic/monitor_db/monitor_db_bloc.dart';
import 'package:walletter/view/my_app/transactions/transaction_list.dart';
import 'package:walletter/view/my_app/user.dart';

import 'home.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 1;
  List<Widget> _pages = [
    TransactionsList(),
    HomeScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MonitorBloc()),
        BlocProvider(create: (_) => ManageFirestoreBloc()),
      ],

      /// Permitir update?!
      // child: BlocListener<ManageFirestoreBloc, ManageState>(
      //   listener: (context, state) {
      //     if (state is UpdateState) {
      //       setState(() {
      //         _currentPage = 3;
      //       });
      //     }
      //   },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Walletter',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.greenAccent.shade700,
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(Logout());
              },
              label: Text("Logout"),
              icon: Icon(Icons.logout),
            )
          ],
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
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: _currentIndex,
                backgroundColor: Color.fromARGB(255, 40, 40, 40),
                selectedItemColor: Colors.white,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.library_books_rounded,
                        size: 25,
                      ),
                      label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        size: 25,
                      ),
                      label: '')
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
                : Color.fromARGB(255, 40, 40, 40),
            child: Icon(Icons.home),
            onPressed: () => setState(
              () {
                _currentIndex = 1;
              },
            ),
          ),
        ),
      ),
    );
  }
}
