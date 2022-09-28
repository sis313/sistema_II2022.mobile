import 'package:app_movil/DTO/Sucursal.dart';
import 'package:flutter/material.dart';

Widget editarSucursal() {
  return MaterialApp(
    title: "Editar Sucursal",
    debugShowCheckedModeBanner: false,
    home: EditarSucursal(),
  );
}

class EditarSucursal extends StatefulWidget {
  const EditarSucursal({Key key}) : super(key: key);

  @override
  State<EditarSucursal> createState() => _EditarSucursalState();
}

class _EditarSucursalState extends State<EditarSucursal>{
  Sucursal sucursal = Sucursal(1, "Sucursal 1", "");

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
