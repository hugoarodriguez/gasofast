import 'package:flutter/material.dart';

import 'package:gasofast/src/pages/change_password_page.dart';
import 'package:gasofast/src/pages/login_page.dart';
import 'package:gasofast/src/pages/recover_account_page.dart';
import 'package:gasofast/src/pages/signup_page.dart';

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
        'signup' : (BuildContext context) => SignUpPage(),
        'recoveracc' : (BuildContext context) => RecoverAccountPage(),
        'changepwd' : (BuildContext context) => ChangePasswordPage(),
      },
    );
  }
}