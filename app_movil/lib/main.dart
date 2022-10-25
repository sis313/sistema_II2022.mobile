import 'package:app_movil/ClienteServicios.dart';
import 'package:app_movil/ComentariosNegocio.dart';
import 'package:app_movil/Login.dart';
import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'StartMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: BoActiveProvider())],
      child: MaterialApp(
        title: 'Mip',
        theme: ThemeData(
          primaryColor: Colors.black
        ),
        debugShowCheckedModeBanner: false,
        home: StartMenu(),
      ),
    );
  }
}
