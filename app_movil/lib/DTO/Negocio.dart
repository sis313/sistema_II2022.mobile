import 'Sucursal.dart';

class Negocio {
  int id_business;
  int id_type_business;
  int id_user;
  String name = '';
  String description;

  List<Sucursal> sucursales = [];

  bool wState = false;

  Negocio(this.id_business, this.name, this.sucursales);
  
}