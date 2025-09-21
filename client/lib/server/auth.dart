import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza/constants.dart';
import 'package:pizza/server/services/user.dart';
import 'package:http/http.dart' as http;

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<MyUser?> register(email, password, name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user == null) return null;
      final idToken = await user.getIdToken();

      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/user'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': ' application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phoneNumber': '',
          'location': '',
        }),
      );

      if (response.statusCode == 200) {
        print("✅ User saved to backend: ${response.body}");
      } else {
        print("❌ Backend error: ${response.statusCode} - ${response.body}");
      }

      return MyUser(uid: user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<MyUser?> login(email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user == null) return null;
      return MyUser(uid: user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<MyUser?> get user => _auth.authStateChanges().map((user) {
    return user == null ? null : MyUser(uid: user.uid);
  });

  Stream<String?> get token async* {
    await for (final user in _auth.idTokenChanges()) {
      if (user == null) {
        yield null;
      } else {
        yield await user.getIdToken();
      }
    }
  }
}
