import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pizza/constants.dart';

class Favourite with ChangeNotifier {
  List<int> favs = [];

  Future<void> fetchFavs(String idToken) async {
    print("fetching favs");
    try {
      final result = await http.get(
        Uri.parse('${AppConfig.baseUrl}/favourite'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
      );

      if (result.statusCode != 200) {
        throw Exception(
          "Failed to get favourite: ${result.statusCode} - ${result.body}",
        );
      }

      favs = List<int>.from(jsonDecode(result.body));
      print("favs Fetched");
    } catch (e) {
      debugPrint("Fetch favs error: $e");
      rethrow;
    }
  }

  Future<void> triggerFav(int id, String idToken) async {
    try {
      if (favs.contains(id)) {
        final oldFavs = List<int>.from(favs);
        favs.remove(id);
        notifyListeners();

        final result = await http.delete(
          Uri.parse('${AppConfig.baseUrl}/favourite'),
          headers: {
            'Authorization': 'Bearer $idToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"pizza_id": id}),
        );

        if (result.statusCode != 200) {
          favs = oldFavs; // rollback
          notifyListeners();
          throw Exception(
            "Failed to remove favourite: ${result.statusCode} - ${result.body}",
          );
        }

        debugPrint("favourite removed");
      } else {
        favs.add(id);
        notifyListeners();

        final result = await http.post(
          Uri.parse('${AppConfig.baseUrl}/favourite'),
          headers: {
            'Authorization': 'Bearer $idToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"pizza_id": id}),
        );

        if (result.statusCode != 200) {
          favs.remove(id); // rollback
          notifyListeners();
          throw Exception(
            "Failed to add favourite: ${result.statusCode} - ${result.body}",
          );
        }

        debugPrint("favourite added");
      }
    } catch (e) {
      debugPrint("Trigger fav error: $e");
      rethrow;
    }
  }
}
