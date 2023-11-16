// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:my_app/models/address_model.dart';

// ignore_for_file: non_constant_identifier_names
class ImageModel {
  String publicId;
  String url;

  ImageModel({required this.publicId, required this.url});

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(publicId: map['publicId'] ?? "", url: map['url'] ?? '');
  }
}

class User {
  final String id;
  final String email;
  final String userName;
  final String firstName;
  final String lastName;
  final String accessToken;
  final String password;
  final String refreshToken;
  final String re_password;
  final ImageModel avatar;
  List<AddressModel> address;

  User({
    required this.id,
    required this.email,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.re_password,
    required this.accessToken,
    required this.refreshToken,
    required this.avatar,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'accessToken': accessToken,
      'password': password,
      'refreshToken': refreshToken,
      're_password': re_password,
      'avatar': avatar,
      'address': address.map((x) => x.toMap()).toList(),
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
      avatar: map['avatar'] != null
          ? ImageModel.fromMap(map['avatar'])
          : ImageModel(publicId: 'publicId', url: 'url'),
      address: List<AddressModel>.from(
          map["address"].map((x) => AddressModel.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
