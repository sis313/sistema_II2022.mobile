import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoActiveProvider extends ChangeNotifier {
  // Static data
  final String apiURL = "serviceprojectspring.herokuapp.com";

  // Return data
  String cityResponse;

  // Methods
  void getCity() async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, 'api/city');
    final response = await http.get(url);
    print("Response listo!");

    print("Response status: ${response.statusCode}"); // retorna un numero
    print("Response body: ${response.body}"); // retorna una lista
  }


  void getMunicipio() async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, 'api/municipalities');
    final response = await http.get(url);
    print("furula!");

    print("Response status: ${response.statusCode}"); // retorna un numero
    print("Response body: ${response.body}"); // retorna una lista
  }
  void getComent() async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, '/api/comment');
    final response = await http.get(url);
    print("furula!");

    print("Response status: ${response.statusCode}"); // retorna un numero
    print("Response body: ${response.body}"); // retorna una lista
  }
  void getRanting() async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, '/api/rating');
    final response = await http.get(url);
    print("furula!");

    print("Response status: ${response.statusCode}"); // retorna un numero
    print("Response body: ${response.body}"); // retorna una lista
  }
  void getByIDMunicipio(int id) async {
    print("Haciendo peticion...");
    var url = Uri.https(apiURL, 'api/municipalities/$id');
    final response = await http.get(url);
    print("furula!");

    print("Response status: ${response.statusCode}"); // retorna un numero
    print("Response body: ${response.body}"); // retorna una lista
  }
}