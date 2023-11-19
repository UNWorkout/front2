import 'package:flutter/material.dart';
import 'package:un_work_out/register/register_view.dart';
import 'package:un_work_out/login/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/register': (context) => RegisterPage(title: 'unworkout'),
        '/login': (context) => LoginPage(title: 'unworkout'),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage(title: 'unworkout'),
    );
  }
}
