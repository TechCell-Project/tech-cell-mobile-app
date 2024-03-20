import 'package:flutter/material.dart';
import 'package:my_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    userName: '',
    firstName: '',
    lastName: '',
    password: '',
    re_password: '',
    accessToken: '',
    refreshToken: '',
    avatar: ImageModel(publicId: '', url: ''),
    address: [],
    role: '',
    createdAt: '',
    updatedAt: '',
  );
  User get user => _user;

  setUser(dynamic user) {
    _user = User.fromJson(user);
    // saveUserToStorage();
    notifyListeners();
  }

  // void setUserFromModels(User user) {
  //   _user = user;
  //   saveUserToStorage();
  //   notifyListeners();
  // }

  Future<void> loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      _user = User.fromJson(userJson);
      notifyListeners();
    }
  }

  Future<void> saveUserToStorage(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', _user.toJson());
  }

  Future<User?> getUserToStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userStorage = prefs.getString('user');

    if (userStorage != null) {
      return _user;
    } else {
      return null;
    }
  }
}
