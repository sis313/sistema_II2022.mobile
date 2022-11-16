import 'dart:convert';

import 'package:app_movil/DTO/Branch.dart';
import 'package:app_movil/DTO/Business.dart';
import 'package:app_movil/DTO/Comment.dart';
import 'package:app_movil/DTO/Location.dart';
import 'package:app_movil/DTO/Rating.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../DTO/TypeBusiness.dart';

class BoActiveProvider extends ChangeNotifier {
  // Static data
  final String apiURL = "serviceprojectspring.herokuapp.com";
  List<TypeBusiness> allTypeBusiness = [];
  List<Business> allBusiness = [];
  List<Business> allBusinessByUserId = [];
  List<Comment> allcommet=[];
  List<Branch> allBranch = [];
  List<Rating> allRating = [];

  // Return data
  String cityResponse;

  // Methods
  getCity() async {
    print("Getting city...");
    var url = Uri.https(apiURL, 'api/city');
    final response = await http.get(url);
    print("Response body: ${response.body}");
    return response.body; // retorna una lista
  }

  getMunicipio() async {
    print("Getting municipio...");
    var url = Uri.https(apiURL, 'api/municipalities');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  getByIDMunicipio(int id) async {
    print("Getting municipio by id...");
    var url = Uri.https(apiURL, 'api/municipalities/$id');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  getComent() async {
    print("Getting comments...");
    var url = Uri.https(apiURL, '/api/comment');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  Future<List<Rating>>getRanting() async {
    print("Getting ratings...");
    var url = Uri.https(apiURL, '/api/rating');
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
      r.idUser = item['idUser'];
      rating.add(r);
    }
    this.allRating = rating;
    return rating;
  }

  deleteComment(int id) async {
    print("Deleting comment $id...");
    final http.Response response = await http.delete(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/comment/$id'),
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

  createComment(String message, int idUser, int idBusinness) async {
    print("Creating comments...");
    final response = await http.post(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/comment'),
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
    return response.body;
  }

  updateComment(int id, String message, int idUser, int idBussiness) async {
    print("Updating comment $id...");
    final response = await http.put(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/comment/$id'),
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
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/rating'),
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
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/rating/$idRating'),
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
    var url = Uri.https(apiURL, '/api/business');
    final response = await http.get(url);
    print(response.body);

    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
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
    var url = Uri.https(apiURL, '/api/business/$id');
    final response = await http.get(url);
    print(response.body);

    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
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
    var url = Uri.https(apiURL, '/api/business/', queryParams);
    final response = await http.get(url);
    print(response.body);

    String body = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(body);
    List<Business> business = [];

    for(var item in jsonData){
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
      String createDate, String updateDate) async {
    print("Creating business...");
    var url = Uri.https(this.apiURL, '/api/business');
    final response = await http.post(
      url,
      //Uri.parse('https://serviceprojectspring.herokuapp.com/api/business'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Accept": 'application/json'
      },
      body: jsonEncode(<String, Object>{
        "name": name,
        "description": desc,
        "idTypeBusiness": idTypeBusiness,
        "idUser": idUser,
        "createDate": createDate,
        "updateDate": updateDate,
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

  updateBusiness(int id, String name, String desc, int idTypeBusiness,
      int idUser, String createDate, String updateDate) async {
    var response = await http.put(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/business/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name": name,
        "description": desc,
        "idTypeBusiness": idTypeBusiness.toString(),
        "idUser": idUser.toString(),
        "createDate": createDate,
        "updateDate": updateDate,
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

  deleteBusinessById(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/business/$id'),
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

    var url = Uri.https(apiURL, '/api/typeBusiness');
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
    var url = Uri.https(apiURL, '/api/typeBusiness/$id');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  createTypeBusiness(String name) async {
    var url = Uri.https(this.apiURL, '/api/typeBusiness');
    var response = await http.post(
      url,
      //return http.post(
      //Uri.parse('https://serviceprojectspring.herokuapp.com/api/typeBusiness'),
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
      Uri.parse(
          'https://serviceprojectspring.herokuapp.com/api/typeBusiness/$id'),
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
      Uri.parse(
          'https://serviceprojectspring.herokuapp.com/api/typeBusiness/$id'),
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

  getLocation() async {
    print("Getting Location...");
    var url = Uri.https(apiURL, '/api/location');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  getLocationById(int id) async {
    print("Getting Location By id...");
    var url = Uri.https(apiURL, '/api/location/$id');
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
    var url = Uri.https(this.apiURL, '/api/location');
    var response = await http.post(
      url,
      //return http.post(
      // Uri.parse('https://serviceprojectspring.herokuapp.com/api/location'),
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

  updateLocation(int id, double latitude, double longitude) async {
    var response = await http.put(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/location/$id'),
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
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/location/$id'),
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
    var url = Uri.https(apiURL, '/api/branch');
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
    var url = Uri.https(apiURL, '/api/branch/$id');
    final response = await http.get(url);
    print(response.body);
    return response.body;

  }

  getBranchByBusinessId(int id) async {
    print("Getting Branch By Business id...");
    final queryParams = {'businessId': id.toString()};
    var url = Uri.https(apiURL, '/api/branch/', queryParams);
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
      String openHour,
      String closeHour,
      String attentionDays,
      String image,
      int idZone,
      int idLocation,
      int idBusiness,
      String createDate,
      String updateDate) async {
    var url = Uri.https(this.apiURL, '/api/branch');
    var response = await http.post(
      url,
      //return http.post(
      //Uri.parse('https://serviceprojectspring.herokuapp.com/api/branch'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "address": address,
        "openHour": openHour,
        "closeHour": closeHour,
        "attentionDays": attentionDays,
        "image": image,
        "idZone": idZone.toString(),
        "idLocation": idLocation.toString(),
        "idBusiness": idBusiness.toString(),
        "createDate": createDate,
        "updateDate": updateDate,
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

  updateBranch(
      int id,
      String address,
      String openHour,
      String closeHour,
      String attentionDays,
      String image,
      int idZone,
      int idLocation,
      int idBusiness,
      String createDate,
      String updateDate) async {
    var response = await http.put(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/branch/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "address": address,
        "openHour": openHour,
        "closeHour": closeHour,
        "attentionDays": attentionDays,
        "image": image,
        "idZone": idZone.toString(),
        "idLocation": idLocation.toString(),
        "idBusiness": idBusiness.toString(),
        "createDate": createDate,
        "updateDate": updateDate,
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

  deleteBranch(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/branch/$id'),
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
}
