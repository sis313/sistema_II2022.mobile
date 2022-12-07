class User {
  int idUser;
  String name;
  String email;
  String nickname;
  int idTypeUser;
  String createDate;
  String updateDate;
  String role;

  User({this.idUser, this.name, this.email, this.nickname, this.idTypeUser,
      this.createDate, this.updateDate, this.role});

  void logout(){
    this.idUser = null;
    this.name = null;
    this.email = null;
    this.nickname = null;
    this.idTypeUser = null;
    this.createDate = null;
    this.updateDate = null;
    this.role = null;
  }
}