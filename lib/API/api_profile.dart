// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Providers/user_provider.dart';

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

  Future<void> getProfileUser(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;
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
        onSuccess: () async {},
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }
}
