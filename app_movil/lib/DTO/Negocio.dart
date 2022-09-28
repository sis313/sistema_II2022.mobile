import 'Sucursal.dart';

class Negocio {
  int id;
  String nombre = '';
  List<Sucursal> sucursales = [];

  bool wState = false;

  Negocio(this.id, this.nombre, this.sucursales);
}