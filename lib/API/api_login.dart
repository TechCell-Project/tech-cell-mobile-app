import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Pages/Screens/main_screen.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLogin {
  Future<void> loginUser({
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
          await prefs.setString(
              'refreshToken', jsonDecode(res.body)['refreshToken']);
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

  void signInWithGoogle({required BuildContext context}) async {
    try {
      // final GoogleSignIn signinInstance =
      //     GoogleSignIn(scopes: ['openid', 'email', 'profile']);
      // final GoogleSignInAccount? googleUser = await signinInstance.signIn();
      // if (googleUser == null) {
      //   // ignore: use_build_context_synchronously
      //   return showSnackBarError(context, 'Sigin Google failed');
      // }

      // final GoogleSignInAuthentication googleAuth =
      //     await googleUser.authentication;
      // String? idToken = googleAuth.idToken;

      // await signinInstance.signIn().then((result) {
      //   result?.authentication.then((googleKey) {
      //     print(googleKey.accessToken);
      //     print(googleKey.idToken);
      //     print(signinInstance.currentUser?.displayName);
      //   }).catchError((err) {
      //     print('inner error');
      //   });
      // }).catchError((err) {
      //   print('error occured');
      // });

      // print(googleAuth.);
      // print('ggAUTH:: ${googleAuth.toString()}');
      // print('idToken:: ${googleAuth.idToken}');
      // final response = await http.post(
      //   Uri.parse('${uri}auth/google'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: jsonEncode(<String, String>{
      //     'idToken': idToken!,
      //   }),
      // );
      // // ignore: use_build_context_synchronously
      // httpErrorHandle(
      //   response: response,
      //   context: context,
      //   onSuccess: () async {
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     userProvider.setUser(response.body);
      //     await prefs.setString(
      //         'accessToken', jsonDecode(response.body)['accessToken']);
      //     await prefs.setString(
      //         'refreshToken', jsonDecode(response.body)['refreshToken']);
      //     // ignore: use_build_context_synchronously
      //     Navigator.of(context).pushAndRemoveUntil(
      //         MaterialPageRoute(builder: (context) => const MainScreen()),
      //         (route) => false);
      //   },
      // );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBarError(context, e.toString());
    }
  }

  Future<void> signOut(BuildContext context) async {
    final googleSigin = GoogleSignIn();
    await googleSigin.signOut();
    // ignore: use_build_context_synchronously
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
      (route) => false,
    );
  }
}
