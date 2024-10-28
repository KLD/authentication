import 'dart:io';

import 'package:adopt_app/models/user.dart';
import 'package:adopt_app/services/auth.dart';
import 'package:adopt_app/services/client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Auth State is represented  with user object. If it's null, user is not authenticated.

class AuthProvider extends ChangeNotifier {
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
}
