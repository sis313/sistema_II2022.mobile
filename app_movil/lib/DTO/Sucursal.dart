class Sucursal{
  int id_branch;
  int id_zone;
  int id_location;
  int id_business;
  String address = "descr";
  DateTime open_hour;
  DateTime close_hour;
  String attention_days;


  String name = "Name";

  Sucursal(this.id_branch, this.name, this.address);

  /*Sucursal(this.id_branch, this.id_zone, this.id_location, this.id_business,
      this.address, this.open_hour, this.close_hour, this.attention_days);*/
}