import 'package:flutter/material.dart';

class servicio {
  String id;
  String _nombre;
  int _contacto;
  String _descripcion;
  String _tipo;
  String _estado;
  bool favorito;
  int calificacion;

  servicio(this.id, this._nombre, this._contacto, this._descripcion, this._tipo,
      this._estado, this.favorito, this.calificacion);

  @override
  String toString() {
    return 'servicio{id: $id, _nombre: $_nombre, _contacto: $_contacto, _descripcion: $_descripcion, _tipo: $_tipo, _estado: $_estado}';
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  int get contacto => _contacto;

  set contacto(int value) {
    _contacto = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }
}
