import 'dart:convert';

import 'package:app_movil/DTO/Business.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../DTO/TypeBusiness.dart';

class BoActiveProvider extends ChangeNotifier {
  // Static data
  final String apiURL = "serviceprojectspring.herokuapp.com";
  List<TypeBusiness> allTypeBusiness = [];
  List<Business> allBusiness = [];

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
    return response.body; // retorna una lista
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

  getRanting() async {
    print("Getting ratings...");
    var url = Uri.https(apiURL, '/api/rating');
    final response = await http.get(url);
    print(response.body);
    return response.body;
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

  getBusinessById(int id) async {
    print("Getting Business By id...");
    var url = Uri.https(apiURL, '/api/business/$id');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  getBusinessByUserId(int id) async {
    print("Getting Business By User id...");
    final queryParams = {'userId': id.toString()};
    var url = Uri.https(apiURL, '/api/business/', queryParams);
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  createBusiness(String name, String desc, int idTypeBusiness, int idUser,
      String createDate, String updateDate) async {
    print("Creating business...");
    var url = Uri.https(this.apiURL, '/api/business');
    var response = await http.post(
      url,
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
    return response.body;
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

  getBranch() async {
    print("Getting Branch...");
    var url = Uri.https(apiURL, '/api/branch');
    final response = await http.get(url);
    print(response.body);
    return response.body;
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
    return response.body;
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