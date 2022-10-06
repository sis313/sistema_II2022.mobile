import 'package:app_movil/ClienteServicios.dart';
import 'package:app_movil/Login.dart';
import 'package:flutter/material.dart';
import 'StartMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mip',
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      debugShowCheckedModeBanner: false,
      home: StartMenu(),
    );
  }
}
