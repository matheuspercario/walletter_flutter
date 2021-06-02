import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:walletter/view/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Launcher());
}

class Launcher extends StatelessWidget {
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
      home: Wrapper(),
    );
  }
}


