import 'package:flutter/material.dart';
import 'package:aplicativo/pages/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF603FFF),
        accentColor: Color.fromARGB(255, 0, 0, 0),
        fontFamily: 'Poppins',
      ),
      home: Welcome(),
    );
  }
}
