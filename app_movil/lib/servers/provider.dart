import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoActiveProvider extends ChangeNotifier {
  // Static data
  final String apiURL = "serviceprojectspring.herokuapp.com";

  // Return data
  String cityResponse;

  // Methods
  getCity() async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, 'api/city');
    final response = await http.get(url);
    print("Response listo!");

    print("Response status: ${response.statusCode}"); // retorna un numero
    print("Response body: ${response.body}");
    return response.body; // retorna una lista
  }

  getMunicipio() async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, 'api/municipalities');
    final response = await http.get(url);
    return response.body; // retorna una lista
  }

  getComent() async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, '/api/comment');
    final response = await http.get(url);
    return response.body;
  }

  getRanting() async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, '/api/rating');
    final response = await http.get(url);
    return response.body;
  }

  getByIDMunicipio(int id) async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, 'api/municipalities/$id');
    final response = await http.get(url);
    return response.body;
  }

  deleteComment(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/comment/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  createComment(String message, int idUser, int idBusinness) {
    return http.post(
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
  }

  updateComment(int id, String message, int idUser, int idBussiness) async {
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

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update .');
    }
  }

  createRanking(int score, int idBranch, int idUser) {
    return http.post(
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
  }

//Business

  getBusiness() async {
    print("Getting Business...");
    var url = Uri.https(apiURL, '/api/business');
    final response = await http.get(url);
    print(response.body);
    return response.body;
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
    final queryParams = {
      'userId': id.toString()
    };
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
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  //TypeBusiness
  getTypeBusiness() async {
    print("Getting TypeBusiness...");
    var url = Uri.https(apiURL, '/api/typeBusiness');
    final response = await http.get(url);
    return response.body;
  }

  getTypeBusinessById(int id) async {
    print("Getting TypeBusiness By id...");
    var url = Uri.https(apiURL, '/api/typeBusiness/$id');
    final response = await http.get(url);
    return response.body;
  }

  createTypeBusiness(String name) {
    return http.post(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/typeBusiness'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"name": name}),
    );
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
    return response.body;
  }

  getLocationById(int id) async {
    print("Getting Location By id...");
    var url = Uri.https(apiURL, '/api/location/$id');
    final response = await http.get(url);
    return response.body;
  }

  createLocation(double latitude, double longitude) {
    return http.post(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/location'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "latitude": latitude.toString(),
        "longitude": longitude.toString()
      }),
    );
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
    return response.body;
  }

  getBranchById(int id) async {
    print("Getting Branch By id...");
    var url = Uri.https(apiURL, '/api/branch/$id');
    final response = await http.get(url);
    return response.body;
  }

  getBranchByBusinessId(int id) async {
    print("Getting Branch By Business id...");
    var url = Uri.https(apiURL, '/api/branch/?businessId=$id');
    final response = await http.get(url);
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
      String updateDate) {
    return http.post(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/branch'),
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
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete album.');
    }
  }
}
