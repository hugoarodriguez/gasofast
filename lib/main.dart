import 'package:flutter/material.dart';
import 'package:gasofast/src/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gasofast',
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
      },
    );
  }
}