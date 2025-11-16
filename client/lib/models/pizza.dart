import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:pizza/constants.dart';



class Pizza with ChangeNotifier {
  List<dynamic> pizzas = [];
  String? _lastToken;
  String? get lastToken => _lastToken;
  Future<void> fetchPizza(idToken) async {
    
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/pizza"),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': ' application/json',
      },
    );

    if (response.statusCode == 200) {
      _lastToken = idToken;
      pizzas = jsonDecode(response.body);
      print("pizza fetched ");
    } else {
      print("Failed with status ${response.statusCode}");
    }
  }
}
