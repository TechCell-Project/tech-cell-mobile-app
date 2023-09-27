import 'dart:convert';

class User {
  final String id;
  final String email;
  final String userName;
  final String firstName;
  final String lastName;
  final String accessToken;
  final String password;
  final String re_password;

  User({
    required this.id,
    required this.email,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.re_password,
    required this.accessToken,
  });

  Map<String, String> toMap() {
    return <String, String>{
      'email': email,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'accessToken': accessToken,
      'password': password,
      're_password': re_password,
    };
  }

  factory User.fromMap(Map<String, String> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      accessToken: map['accessToken'] as String,
      password: map['password'] as String,
      re_password: map['re_password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, String>);
}
