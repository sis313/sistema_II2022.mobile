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
    return response.body;// retorna una lista
  }


   getMunicipio() async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, 'api/municipalities');
    final response = await http.get(url);
    return response.body;// retorna una lista
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
   updateComment(int id,String message, int idUser, int idBussiness) async {
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
  createRanking(int score,int idBranch, int idUser){
    return http.post(
      Uri.parse('https://serviceprojectspring.herokuapp.com/api/rating'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "score": score.toString(),
        "favoriteStatus": true.toString(),
        "idBranch":1.toString(),
        "idUser":1.toString()
      }),
    );
  }


}