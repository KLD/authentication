import 'dart:io';

import 'package:adopt_app/models/user.dart';
import 'package:adopt_app/services/auth.dart';
import 'package:adopt_app/services/client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Auth State is represented  with user object. If it's null, user is not authenticated.

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    print("I have created");
  }
  User? user;

  Future<void> signup({required String email, required String password}) async {
    // state mutation (set user object)
    user = await signupAPI(email, password);
    notifyListeners();

    //Set authorization header in Dio client
    dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    // Storing username and token using shared_prefrences
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user!.username);
    prefs.setString("token", user!.token);
  }

  Future<void> loadPreviousUser() async {
    // read from shared
    var prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var token = prefs.getString("token");

    if (username == null || token == null) {
      prefs.remove("username");
      prefs.remove("token");
      return;
    }

    dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    // create user object
    user = User(token: token, username: username);
    // assign in state
    notifyListeners();
  }
}
