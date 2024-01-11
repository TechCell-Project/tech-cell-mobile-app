// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Pages/Tabs/veryfile_email.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';

class AuthSignUp {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String userName,
    required String firstName,
    required String lastName,
    required String password,
    required String rePassword,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${uri}auth/register'),
        body: json.encode({
          'email': email,
          'userName': userName,
          'password': password,
          're_password': rePassword,
          'firstName': firstName,
          'lastName': lastName
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBarSuccess(context, 'Đăng ký thành công');
          sendOTPVerifyEmail(context: context, email: email);
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }

  void sendOTPVerifyEmail({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${uri}auth/resend-verify-email-otp'),
          body: json.encode({'email': email}),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyEmail(email: email),
            ),
          );
        },
      );
    } catch (e) {
      showSnackBarError(context, 'loi cho nay');
    }
  }

  void resentOtpVerifyEmail({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${uri}auth/resend-verify-email-otp'),
          body: json.encode({'email': email}),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBarSuccess(context, 'Vui long check email');
        },
      );
    } catch (e) {
      showSnackBarError(context, 'loi cho nay');
    }
  }

  void verifyEmail({
    required BuildContext context,
    required String otp,
    required String email,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('${uri}auth/resend-verify-email-otp'),
        body: json.encode({
          'email': email,
          'otpCode': otp,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBarSuccess(context, 'Đăng ký thành công');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }
}
