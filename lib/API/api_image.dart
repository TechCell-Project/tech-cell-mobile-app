// ignore: avoid_web_libraries_in_flutter

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/user_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class Avatar {
  Future<ImageModel?> postImage({
    required BuildContext context,
    File? image,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;
      if (accessToken.isEmpty) {
        final newAccessToken = await AuthLogin.getAccessToken();
        accessToken = newAccessToken!;
      }
      var request = http.MultipartRequest('POST', Uri.parse('${uri}images'));
      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer $accessToken';

      String fileType = image!.path.split('.').last.toLowerCase();
      var validExtensions = ['.jpeg', '.jpg', '.png', '.gif', '.webp'];
      if (!validExtensions.contains('.$fileType')) {
        return null;
      }
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', fileType),
      ));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
        Map<String, dynamic> responseMap = json.decode(responseBody);
        return ImageModel.fromMap(responseMap);
      } else {
        return null;
      }
    } catch (e) {
      showSnackBarError(context, 'allololl');
      return null;
    }
  }
}
