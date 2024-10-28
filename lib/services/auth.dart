import 'package:adopt_app/models/user.dart';
import 'package:adopt_app/services/client.dart';

/// Calls API `/signup` by sending email and password in body
Future<User> signupAPI(String email, String password) async {
  // send request to API and store response
  var response = await dio.post("/signup", data: {
    "email": email,
    "password": password,
  });

  // parse response from Map into User object and return it
  return User.fromJson(response.data['data']);
}
