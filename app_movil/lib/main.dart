import 'package:app_movil/ClienteServicios.dart';
import 'package:app_movil/ComentariosNegocio.dart';
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
      title: 'Login',
      debugShowCheckedModeBanner: false,
      home: StartMenu(),
    );
  }
}
