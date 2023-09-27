import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';

class AuthLogin {
  void loginUser({
    required BuildContext context,
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${uri}auth/login'),
        body: jsonEncode(
          {
            'emailOrUsername': emailOrUsername,
            'password': password,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBarSuccess(context, 'login thanh cong');
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // userProvider.setUser(res.body);
          // await prefs.setString('token', jsonDecode(res.body)['accessToken']);
          // navigator.pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => const HomeScreen()),
          //     (route) => false);
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBarError(context, e.toString());
    }
  }
}
