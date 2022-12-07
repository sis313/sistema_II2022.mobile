class Business {
  int idBusiness;
  String name;
  String description;
  int idTypeBusiness;
  int idUser;
  String createDate;
  String updateDate;
  bool status;

  bool wState = false;

  Business({this.idBusiness, this.name, this.description, this.idTypeBusiness, this.idUser, this.createDate, this.updateDate, this.status});
}