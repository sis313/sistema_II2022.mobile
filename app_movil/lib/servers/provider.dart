import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoActiveProvider extends ChangeNotifier {
  // Static data
  final String apiURL = "https://serviceprojectspring.herokuapp.com";

  // Return data
  String cityResponse;

  // Methods
  Future<String> getCity() async {
    var url = Uri.https(apiURL, 'api/city');
    final response = await http.get(url);

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    cityResponse = response.toString();
    return cityResponse;
  }
}