import 'dart:convert';

class User {
  final String id;
  final String email;
  final String userName;
  final String firstName;
  final String lastName;
  final String accessToken;
  final String password;
  final String refreshToken;
  // ignore: non_constant_identifier_names
  final String re_password;

  User(
      {required this.id,
      required this.email,
      required this.userName,
      required this.firstName,
      required this.lastName,
      required this.password,
      // ignore: non_constant_identifier_names
      required this.re_password,
      required this.accessToken,
      required this.refreshToken});

  Map<String, dynamic> toMap() {
    return <String, String>{
      'email': email,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'password': password,
      're_password': re_password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      password: map['password'] ?? '',
      re_password: map['re_password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
