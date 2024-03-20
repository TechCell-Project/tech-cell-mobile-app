import 'dart:convert';

import 'package:my_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _nameKey = 'userName';
  static const String _firstNameKey = 'firstName';
  static const String _lastNameKey = 'lastName';
  static ImageModel avatar = ImageModel(publicId: '', url: '');
  static String json = jsonEncode(avatar.toJson());

  static Future<void> saveUserToStorage(
      String name, String firstName, String lastName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_firstNameKey, firstName);
    await prefs.setString(_lastNameKey, lastName);
    await prefs.setString('avatar', json);
  }

  static Future<User?> getUserfromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userName = prefs.getString(_nameKey);
    final String? firstName = prefs.getString(_firstNameKey);
    final String? lastName = prefs.getString(_lastNameKey);
    if (userName != null && firstName != null && lastName != null) {
      return User(
        userName: userName,
        firstName: firstName,
        lastName: lastName,
        id: '',
        email: '',
        password: '',
        re_password: '',
        accessToken: '',
        refreshToken: '',
        avatar: avatar,
        address: [],
        createdAt: '',
        role: '',
        updatedAt: '',
      );
    } else {
      return null;
    }
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<void> setAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> setRefreshToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
  }

  static Future<void> clearTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_firstNameKey);
    await prefs.remove(_lastNameKey);
    await prefs.remove(_nameKey);
  }
}
