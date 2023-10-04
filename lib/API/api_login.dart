import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Pages/Screens/main_screen.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLogin {
  void loginUser({
    required BuildContext context,
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
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
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString(
              'accessToken', jsonDecode(res.body)['accessToken']);
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBarError(context, e.toString());
    }
  }

  // void getUserData(BuildContext context) async {
  //   try {
  //     var userProvider = Provider.of<UserProvider>(context, listen: false);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('accessToken');
  //     String? refreshToken = prefs.getString('refreshToken');
  //     if (token == null) {
  //       prefs.setString('accessToken', '');
  //     }
  //     var tokenRes = await http.post(
  //       Uri.parse('${uri}auth/login'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'accessToken': token!,
  //         'refreshToken': refreshToken!,
  //       },
  //     );
  //     var respone = jsonDecode(tokenRes.body);
  //     if (respone == true) {
  //       http.Response userRes = await http.get(
  //         Uri.parse('${uri}users/me'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'accessToken': token,
  //           'refreshToken': refreshToken,
  //         },
  //       );

  //       userProvider.setUser(userRes.body);
  //       print(refreshToken);
  //     }
  //   } catch (e) {
  //     // ignore: use_build_context_synchronously
  //     // showSnackBarError(context, 'loi o day ');
  //   }
  // }

  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
      (route) => false,
    );
  }
}
