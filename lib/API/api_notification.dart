// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/models/notification_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationApi {
  Future<NotificationUser> getNotification(
      BuildContext context, IO.Socket socket, String readType) async {
    NotificationUser notificationUser = NotificationUser(
        page: 1, pageSize: 1, totalPage: 1, totalRecord: 1, data: []);
    try {
      var accessToken =
          Provider.of<UserProvider>(context, listen: false).user.accessToken;
      if (accessToken.isEmpty) {
        final newAccessToken = await AuthLogin.getAccessToken();
        accessToken = newAccessToken!;
      }
      http.Response res = await http.get(
        Uri.parse('${uri}notifications?page=1&pageSize=10&readType=$readType'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var jsonResponse = jsonDecode(res.body);
          List<dynamic> notificationData = jsonResponse['data'];
          for (var notification in notificationData) {
            String notificationJson = jsonEncode(notification);
            DataNotificationUser dataNotification =
                DataNotificationUser.fromJson(notificationJson);
            socket.emit('newNotification', notification);
            notificationUser.data.add(dataNotification);
          }
        },
      );
    } catch (e, i) {
      print('loix $e');
      print(i);
      // showSnackBarError(context, e.toString());
    }
    return notificationUser;
  }
}
