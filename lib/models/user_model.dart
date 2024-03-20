// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:my_app/models/address_model.dart';

// ignore_for_file: non_constant_identifier_names
class ImageModel {
  String publicId;
  String url;

  ImageModel({required this.publicId, required this.url});
  Map<String, dynamic> toJson() {
    return {
      'publicId': publicId,
      'url': url,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      publicId: map['publicId'] ?? "",
      url: map['url'] ?? '',
    );
  }
}

class User {
  String id;
  String email;
  String userName;
  String firstName;
  String lastName;
  String accessToken;
  String password;
  String refreshToken;
  String re_password;
  ImageModel avatar;
  List<AddressModel> address;
  String role;
  String createdAt;
  String updatedAt;

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
    required this.createdAt,
    required this.role,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'email': email,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'password': password,
      // ignore: equal_keys_in_map
      'refreshToken': refreshToken,
      're_password': re_password,
      'avatar': avatar,
      'address': address.map((x) => x.toMap()).toList(),
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
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
      address: map["address"] != null
          ? List<AddressModel>.from(
              (map["address"] as List?)
                      ?.where((x) => x != null)
                      .map((x) =>
                          AddressModel.fromJson(x as Map<String, dynamic>))
                      .toList() ??
                  [],
            )
          : [],
      role: map['role'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
