class User {
  final String token;
  final String username;

  User({required this.token, required this.username});

  factory User.fromJson(dynamic json) {
    return User(
      username: json['user'],
      token: json['token'],
    );
  }

  Map toJson() {
    return {
      "user": username,
      "token": token,
    };
  }
}
