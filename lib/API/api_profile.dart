// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Providers/token_manager.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/models/user_model.dart';

import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';

class ProfileUser {
  Future<void> changeProfile({
    required BuildContext context,
    required String changeInfo,
    required String body,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;
      if (accessToken.isEmpty) {
        var newAccessToken = await AuthLogin.getAccessToken();
        accessToken = newAccessToken!;
      }
      http.Response response = await http.patch(
        Uri.parse('${uri}profile/info'),
        body: {
          body: changeInfo,
        },
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          showSnackBarSuccess(context, 'Thay doi thanh cong');
        },
      );
    } catch (e) {
      showSnackBarError(context, 'e.toString()');
    }
  }

  Future<void> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
    required String reNewPassword,
  }) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    String accessToken = userProvider.user.accessToken;
    if (accessToken.isEmpty) {
      final newAccessToken = await AuthLogin.getAccessToken();
      accessToken = newAccessToken!;
    }

    http.Response res = await http.post(
      Uri.parse('${uri}auth/change-password'),
      body: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'reNewPassword': reNewPassword,
      },
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        showSnackBarSuccess(context, 'Thay doi thanh cong');
        Navigator.pop(context);
      },
    );
  }

  Future<User> getProfileUser(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    User userModele = User(
      id: '',
      email: '',
      userName: '',
      firstName: '',
      lastName: '',
      password: '',
      re_password: '',
      accessToken: AuthLogin.getAccessToken().toString(),
      refreshToken: TokenManager.getRefreshToken().toString(),
      avatar: ImageModel(
        publicId: '',
        url: '',
      ),
      address: [],
      role: '',
      createdAt: '',
      updatedAt: '',
    );
    try {
      String accessToken = userProvider.user.accessToken;
      if (accessToken.isEmpty) {
        final newAccessToken = await AuthLogin.getAccessToken();
        accessToken = newAccessToken!;
      }
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };
      http.Response res = await http.get(
        Uri.parse(
          '${uri}profile',
        ),
        headers: headers,
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          userProvider.setUser(res.body);
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
    return userModele;
  }
}
