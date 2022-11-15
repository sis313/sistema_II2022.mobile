class Branch {
  int id;
  String address;
  String openHour;
  String closeHour;
  String attentionDays;
  String image;
  int idZone;
  int idLocation;
  int idBusiness;
  String createDate;
  String updateDate;
  bool status;

  Branch(
      {this.id,
      this.address,
      this.openHour,
      this.closeHour,
      this.attentionDays,
      this.image,
      this.idZone,
      this.idLocation,
      this.idBusiness,
      this.createDate,
      this.updateDate,
      this.status}
  );
}