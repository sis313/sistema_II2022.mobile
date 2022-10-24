import 'Sucursal.dart';

class Negocio {
  int id_business;
  int id_type_business;
  int id_user;
  String name;
  String description;

  List<Sucursal> sucursales = [];

  bool wState = false;

  Negocio(this.id_business, this.name, this.sucursales);

  /*Negocio(this.id_business, this.id_type_business, this.id_user, this.name,
      this.description);*/
}