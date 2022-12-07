import 'dart:convert';

import 'package:app_movil/DTO/Branch.dart';
import 'package:app_movil/DTO/Business.dart';
import 'package:app_movil/DTO/Comment.dart';
import 'package:app_movil/DTO/Location.dart';
import 'package:app_movil/DTO/Municipality.dart';
import 'package:app_movil/DTO/Rating.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../DTO/City.dart';
import '../DTO/TypeBusiness.dart';
import '../DTO/Zone.dart';

class BoActiveProvider extends ChangeNotifier {
  // Static data
  final String lastApiURL = "serviceprojectspring.herokuapp.com";
  final String apiURL = "projectspring-env.eba-3xmbucvq.us-east-1.elasticbeanstalk.com";
  final String apiUriV2 = "sistema2022.uc.r.appspot.com";
  List<TypeBusiness> allTypeBusiness = [];
  List<City> allCities = [];
  List<Municipality> allMunicipalities = [];
  List<Zone> allZones = [];
  List<Location> allLocations = [];
  List<Business> allBusiness = [];
  List<Business> allBusinessByUserId = [];
  List<Comment> allComment=[];
  List<Branch> allBranch = [];
  List<Rating> allRating = [];

  // Return data
  String cityResponse;

  // Methods
  getCity() async {
    print("Getting city...");
    var url = Uri.http(apiURL, 'api/city');
    final response = await http.get(url);
    print("Response body: ${response.body}");
    return response.body; // retorna una lista
  }

  getMunicipio() async {
    print("Getting municipio...");
    var url = Uri.http(apiURL, 'api/municipalities');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  getByIDMunicipio(int id) async {
    print("Getting municipio by id...");
    var url = Uri.http(apiURL, 'api/municipalities/$id');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  Future<List<Comment>> getCommentbyid(int id) async {
    print("Getting Comments by id: $id");

    final queryParams = {'businessId': id.toString()};
    print("id $id");
    var url = Uri.http(apiURL, '/api/comment/', queryParams);
    final response = await http.get(url);
    print(response.body);
    String body = utf8.decode(response.bodyBytes);
    print("String body: $body");
    final jsonData = json.decode(body);
    print("jsonData: $jsonData");
    List<Comment> comment = [];

    for(var item in jsonData){
      if(item['status'] == 0) continue;
      Comment c = Comment();
      c.idComment = item['idComment'];
      c.message = item['message'];
      c.idUser = item['idUser'];
      c.idBusiness = item['idBusiness'];
      c.status=item['status'];
      comment.add(c);
    }
    print("Array length: ${comment.length}");
    this.allComment = comment;
    return comment;
  }

  Future<List<Rating>>getRanting() async {
    print("Getting ratings...");
    var url = Uri.http(apiURL, '/api/rating/detail');
    final response = await http.get(url);
    print(response.body);
    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    List<Rating> rating = [];

    for(var item in jsonData){
      Rating r = Rating();
      r.idRating = item['idRating'];
      r.score = item['score'];
      r.favoriteStatus = item['favoriteStatus'];
      r.idBranch = item['idBranch'];
      r.businessName=item['businessName'];
      r.idUser = item['idUser'];
      rating.add(r);
    }
    this.allRating = rating;
    return rating;
  }

  deleteComment(int id) async {
    print("Deleting comment $id...");
    final http.Response response = await http.delete(
      Uri.parse("http://$apiURL/api/comment/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      print("si se elimina");
      return response.body;
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  createComment(String message, int idUser, int idBusinness) async {
    print("Creating comments...");
    final response = await http.post(
      Uri.parse("http://$apiURL/api/comment"),



      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "message": message,
        "idUser": idUser.toString(),
        "idBusiness": idBusinness.toString(),
        "status": 1.toString()
      }),
    );
    print(response.body);
    return 'Ok';
  }

  updateComment(int id, String message, int idUser, int idBussiness) async {
    print("Updating comment $id...");
    final response = await http.put(
      Uri.parse("http://$apiURL/api/comment/$id"),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "message": message,
        "idUser": idUser.toString(),
        "idBusiness": idBussiness.toString(),
        "status": 1.toString()
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update .');
    }
  }

  createRanking(int score, int idBranch, int idUser) async {
    print("Creating ranking...");
    final response = await http.post(
      Uri.parse("https://sistema2022.uc.r.appspot.com/api/rating"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "score": score.toString(),
        "favoriteStatus": true.toString(),
        "idBranch": 1.toString(),
        "idUser": 1.toString()
      }),
    );
    print(response.body);
    return response.body;
  }

  updateRating(int idRating, int score, bool favoriteStatus, int idBranch, int idUser) async {
    print("Updating rating $idRating...");
    final response = await http.put(
      Uri.parse(apiURL + "/api/rating/$idRating"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<Object, Object>{
        "id": idRating,
        "score": score,
        "favoriteStatus": favoriteStatus,
        "idBranch": idBranch,
        "idUser": idUser
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update.');
    }
  }


  //Business
  Future<List<Business>>getBusiness() async {
    print("Getting Business...");
    var url = Uri.http(apiURL, '/api/business');
    final response = await http.get(url);
    print(response.body);

    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    print("All business jsonData: $jsonData");
    List<Business> business = [];
    for(var item in jsonData){
      Business b = Business();
      b.idBusiness = item['idBusiness'];
      b.name = item['name'];
      b.description = item['description'];
      business.add(b);
    }
    this.allBusiness = business;
    return business;
  }

  Future<List<Business>> getBusinessById(int id) async {
    print("Getting Business...");
    var url = Uri.http(apiURL, '/api/business/$id');
    final response = await http.get(url);
    print(response.body);

    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    print("Business by id jsonData: $jsonData");
    List<Business> business = [];
    Business m = Business();
    m.idBusiness = jsonData['idBusiness'];
    m.name = jsonData['name'];
    m.description = jsonData['description'];
    business.add(m);

    print(business.length);
    return business;
  }

  Future<List<Business>> getBusinessByUserId(int id) async {
    print("Getting Business By User id...");
    final queryParams = {'userId': id.toString()};
    var url = Uri.http(apiURL, '/api/business/', queryParams);
    final response = await http.get(url);
    print(response.body);

    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    List<Business> business = [];

    for(var item in jsonData){
      if(item['status'] == 0) continue;
      Business b = Business();
      b.idBusiness = item['idBusiness'];
      b.name = item['name'];
      b.description = item['description'];
      business.add(b);
    }
    this.allBusinessByUserId = business;

    print("All business of a user id length: ${business.length}");
    return business;
  }

  createBusiness(String name, String desc, int idTypeBusiness, int idUser,
      DateTime createDate, DateTime updateDate) async {
    print("Creating business...");

    var url = Uri.http(this.apiURL, '/api/business');

    final Map body = {
      "name": name,
      "description": desc,
      "idTypeBusiness": idTypeBusiness,
      "idUser": idUser,
      "createDate": createDate.toIso8601String(),
      "updateDate": updateDate.toIso8601String(),
      "status": 1
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(body),
    );
    /*print("Fecha creacion es ");
    print(createDate);*/

    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create');
    }
  }

  updateBusiness(int id, String name, String desc, int idTypeBusiness,
      int idUser, DateTime updateDate) async {
    var response = await http.put(
      Uri.parse(apiURL + "/api/business/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "name": name,
        "description": desc,
        "idTypeBusiness": idTypeBusiness,
        "idUser": idUser,
        "updateDate": updateDate.toIso8601String(),
        "status": 1
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update .');
    }
  }

  deleteBusinessById(int id) async {
    print('Deleting business id: $id');
    final response = await http.delete(
      Uri.parse("http://$apiURL/api/business/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  //TypeBusiness
  Future<List<TypeBusiness>> getTypeBusiness() async {
    print("Getting TypeBusiness...");
    List<TypeBusiness> list = [];
    var url = Uri.http(apiURL, '/api/typeBusiness');
    final response = await http.get(url);
    print(response.body);
    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    List<TypeBusiness> responseTypeBusiness = [];
    for(var item in jsonData){
      TypeBusiness type = TypeBusiness();
      type.id = item['idTypeBusiness'];
      type.name = item['name'];
      responseTypeBusiness.add(type);
    }
    allTypeBusiness = responseTypeBusiness;
    return responseTypeBusiness;
  }

  getTypeBusinessById(int id) async {
    print("Getting TypeBusiness By id...");
    var url = Uri.http(apiURL, '/api/typeBusiness/$id');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  createTypeBusiness(String name) async {
    var url = Uri.http(this.apiURL, '/api/typeBusiness');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"name": name}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update .');
    }
  }

  updateTypeBusiness(int id, String name) async {
    var response = await http.put(
      Uri.parse(apiURL + "/api/typeBusiness/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"name": name}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update .');
    }
  }

  deleteTypeBusinessById(int id) async {
    final http.Response response = await http.delete(
      Uri.parse(apiURL + "/api/typeBusiness/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  //Location

  Future<List<Location>> getLocation() async {
    print("Getting Location...");
    var url = Uri.http(apiURL, '/api/location');
    final response = await http.get(url);
    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);

    List<Location> responseLocation = [];
    for(var item in jsonData){
      Location type = Location();
      type.id = item['idLocation'];
      type.latitude = item['latitude'];
      type.longitude = item['longitude'];
      responseLocation.add(type);
    }

    allLocations = responseLocation;
    return responseLocation;
  }

  getLocationById(int id) async {
    print("Getting Location By id...");
    var url = Uri.http(apiURL, '/api/location/$id');
    final response = await http.get(url);
    print(response.body);


    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);

      Location location = Location();
      location.id = jsonData['id'];
      location.latitude = jsonData['latitude'];
      location.longitude = jsonData['longitude'];

    return location;

  }

  createLocation(double latitude, double longitude) async {
    var url = Uri.http(this.apiURL, '/api/location');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, double>{
        "latitude": latitude,
        "longitude": longitude
      }),
    );
    //print(response.body);
    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);

    Location type = Location();
    type.id = jsonData['idLocation'];
    type.latitude = jsonData['latitude'];
    type.longitude = jsonData['longitude'];

    if (response.statusCode == 200) {
      return type;
    } else {
      throw Exception('Failed to update .');
    }
  }

  updateLocation(int id, double latitude, double longitude) async {
    var response = await http.put(
      Uri.parse(apiURL + "/api/location/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "latitude": latitude.toString(),
        "longitude": longitude.toString()
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update .');
    }
  }

  deleteLocation(int id) async {
    final http.Response response = await http.delete(
      Uri.parse(apiURL + "/api/location/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  //Branch

  Future<List<Branch>> getBranch() async {
    print("Getting all branches...");
    var url = Uri.http(apiURL, '/api/branch');
    final response = await http.get(url);
    print(response.body);

    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    List<Branch> responseBranch = [];

    for(var item in jsonData){
      Branch branch = Branch();
      branch.idBranch = item['idBranch'];
      branch.address = item['address'];
      branch.openHour = item['openHour'];
      branch.closeHour = item['closeHour'];
      branch.attentionDays = item['attentionDays'];
      branch.image = item['image'];
      branch.idZone = item['idZone'];
      branch.idLocation = item['idLocation'];
      branch.idBusiness = item['idBusiness'];
      branch.createDate = item['createDate'];
      branch.updateDate = item['updateDate'];
      branch.status = item['status'];
      responseBranch.add(branch);
    }
    allBranch = responseBranch;

    print("Branch array length: ${responseBranch.length}");
    return responseBranch;
  }

  getBranchById(int id) async {
    print("Getting Branch By id...");
    var url = Uri.http(apiURL, '/api/branch/$id');
    final response = await http.get(url);
    print(response.body);
    return response.body;

  }

  Future<List<Branch>> getBranchByBusinessId(int id) async {
    print("Getting Branch By Business id $id...");
    final queryParams = {'businessId': id.toString()};
    var url = Uri.http(apiURL, '/api/branch/', queryParams);
    final response = await http.get(url);
    print(response.body);
    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    List<Branch> responseBranch = [];
    for(var item in jsonData){
      Branch branch = Branch();
      branch.idBranch = item['idBranch'];
      branch.address = item['address'];
      branch.openHour = item['openHour'];
      branch.closeHour = item['closeHour'];
      branch.attentionDays = item['attentionDays'];
      branch.image = item['image'];
      branch.idZone = item['idZone'];
      branch.idLocation = item['idLocation'];
      branch.idBusiness = item['idBusiness'];
      branch.createDate = item['createDate'];
      branch.updateDate = item['updateDate'];
      branch.status = item['status'];
      responseBranch.add(branch);
    }
    allBranch = responseBranch;
    print("Branch array length: ${responseBranch.length}");
    return responseBranch;
  }

  createBranch(
      String address,
      DateTime openHour,
      DateTime closeHour,
      String attentionDays,
      String image,
      int idZone,
      int idLocation,
      int idBusiness/*,
      DateTime createDate,
      DateTime updateDate*/) async {
    var url = Uri.http(this.apiURL, '/api/branch/json');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, Object>{
        "address": address,
        "openHour": openHour.toIso8601String(),
        "closeHour": closeHour.toIso8601String(),
        "attentionDays": attentionDays,
        "image": image,
        "idZone": idZone,
        "idLocation": idLocation,
        "idBusiness": idBusiness,
        /*"createDate": createDate.toIso8601String(),
        "updateDate": updateDate.toIso8601String(),*/
        "status": 1
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create .');
    }
  }

  updateBranch(
      int id,
      String address,
      DateTime openHour,
      DateTime closeHour,
      String attentionDays,
      String image,
      int idZone,
      int idLocation,
      int idBusiness,
      String createDate,
      DateTime updateDate) async {
    var response = await http.put(
      Uri.parse(apiURL + "/api/branch/json/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "address": address,
        "openHour": openHour.toIso8601String(),
        "closeHour": closeHour.toIso8601String(),
        "attentionDays": attentionDays,
        "image": image,
        "idZone": idZone,
        "idLocation": idLocation,
        "idBusiness": idBusiness,
        "createDate": createDate,
        "updateDate": updateDate.toIso8601String(),
        "status": 1
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update .');
    }
  }

  deleteBranch(int id) async {
    final http.Response response = await http.delete(
      Uri.parse(apiURL + "/api/branch/json/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  //Ciudades
  Future<List<City>> getCities() async{
    print("Getting City...");
    List<City> list = [];

    var url = Uri.http(apiURL, '/api/city');
    final response = await http.get(url);
    //print(response.body);

    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    List<City> responseCity = [];
    for(var item in jsonData){
      City type = City();
      type.idCity = item['idCity'];
      type.name = item['name'];
      responseCity.add(type);
    }
    allCities = responseCity;
    return responseCity;
  }

  createCity(String name) async{
    var url = Uri.http(this.apiURL, '/api/city');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"name": name}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create .');
    }
  }

  //Municipios
  Future<List<Municipality>> getMunicipalities() async{
    print("Getting Municipality...");
    List<Municipality> list = [];
    var url = Uri.http(apiURL, '/api/municipalities');
    final response = await http.get(url);
    //print(response.body);
    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    List<Municipality> responseMunicipality = [];
    for(var item in jsonData){
      Municipality type = Municipality();
      type.idMunicipalities = item['idMunicipalities'];
      type.idCity = item['idCity'];
      type.name = item['name'];
      responseMunicipality.add(type);
    }
    allMunicipalities = responseMunicipality;
    return responseMunicipality;
  }

  createMunicipality(String name, int idCity) async{
    var url = Uri.http(this.apiURL, '/api/municipalities');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{"name": name, "idCity": idCity}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create .');
    }
  }

  //Zona
  Future<List<Zone>> getZones() async{
    print("Getting Zone...");
    List<Zone> list = [];

    var url = Uri.http(apiURL, '/api/zone');
    final response = await http.get(url);
    //print(response.body);

    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    List<Zone> responseZone = [];
    for(var item in jsonData){
      Zone type = Zone();
      type.idZone = item['idZone'];
      type.idMunicipalities = item['idMunicipalities'];
      type.name = item['name'];
      responseZone.add(type);
    }
    allZones = responseZone;
    return responseZone;
  }

  createZone(String name, int idMunicipalities) async{
    var url = Uri.http(this.apiURL, '/api/zone');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{"name": name, "idMunicipalities": idMunicipalities}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create .');
    }
  }
  //Login-register

  createUser(String name, String email, String nickname, String password,
      int type) async {
    print("Creating business...");

    var url = Uri.https(this.apiUriV2, '/v1/api/user/publico/register');

    final Map body = {
      "name": name,
      "email": email,
      "nickname": nickname,
      "password": password,
      "idTypeUser": type
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(body),
    );
    /*print("Fecha creacion es ");
    print(createDate);*/

    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create');
    }
  }

  /////LOGIN
  login( String nickname, String password) async {
    print("Creating business...");
    var url = Uri.http(this.apiURL, '/auth/signin');
    final Map body = {
      "username": nickname,
      "password": password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Failed to create');
    }
  }
}
