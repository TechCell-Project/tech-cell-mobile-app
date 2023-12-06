import 'package:flutter/material.dart';
import 'package:my_app/models/user_models.dart';

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
  );
  User get user => _user;

  void setUser(dynamic user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModels(User user) {
    _user = user;
    notifyListeners();
  }
}
