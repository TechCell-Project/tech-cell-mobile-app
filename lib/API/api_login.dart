// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:my_app/Pages/Screens/main_screen.dart';
import 'package:my_app/Providers/token_manager.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';

class AuthLogin {
  Future<void> loginUser({
    required BuildContext context,
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

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
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await TokenManager.setAccessToken(
              json.decode(res.body)['accessToken']);
          await TokenManager.setRefreshToken(
              json.decode(res.body)['refreshToken']);
          await TokenManager.saveUserToStorage(
              json.decode(res.body)['userName'],
              json.decode(res.body)['firstName'],
              json.decode(res.body)['lastName']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>  MainScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }

  static Future<String?> getAccessToken() async {
    final accessToken = await TokenManager.getAccessToken();
    if (accessToken == null) {
      await AuthLogin.refreshAccessToken();
    }
    return await TokenManager.getAccessToken();
  }

  static Future refreshAccessToken() async {
    try {
      final String? refreshToken = await TokenManager.getRefreshToken();
      if (refreshToken == null) return;
      final response =
          await http.post(Uri.parse('${uri}auth/refresh-token'), body: {
        "refreshToken": refreshToken,
      });
      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        final newAccessToken = data[response.body]('accessToken');
        await TokenManager.setAccessToken(newAccessToken);
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  void signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignIn signinInstance =
          GoogleSignIn(scopes: ['openid', 'email', 'profile']);
      final GoogleSignInAccount? googleUser = await signinInstance.signIn();
      if (googleUser == null) {
        return showSnackBarError(context, 'Sigin Google failed');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // String? idToken = googleAuth.idToken;

      await signinInstance.signIn().then((result) {
        result?.authentication.then((googleKey) {
          print(googleKey.accessToken);
          print(googleKey.idToken);
        }).catchError((err) {
          print('inner error');
        });
      }).catchError((err) {
        print('error occured');
      });
      // if (idToken == null) return;
      print('ggAUTH:: ${googleAuth.toString()}');
      print('idToken:: ${googleAuth.idToken}');
      sendIdTokenToServer(context, idToken: '${googleAuth.idToken}');
    } catch (e) {
      showSnackBarError(context, 'loi 1111111');
    }
  }

  void sendIdTokenToServer(BuildContext context,
      {required String idToken}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.post(Uri.parse('${uri}auth/google'), body: {
        "idToken": idToken,
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await TokenManager.setAccessToken(
              json.decode(res.body)['accessToken']);
          await TokenManager.setRefreshToken(
              json.decode(res.body)['refreshToken']);
          await TokenManager.saveUserToStorage(
              json.decode(res.body)['userName'],
              json.decode(res.body)['firstName'],
              json.decode(res.body)['lastName']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    final googleSigin = GoogleSignIn();
    await googleSigin.signOut();
    final navigator = Navigator.of(context);
    await TokenManager.clearTokens();
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
      (route) => false,
    );
  }
}
