// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';

class Address {
  Future<void> pathAddress(
      {required BuildContext context,
      required String addressName,
      required String customerName,
      required String phoneNumbers,
      required int provinceId,
      required String provinceName,
      required int districtId,
      required String districtName,
      required String wardCode,
      required String wardName,
      required String detail}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;

      http.Response res = await http.patch(
        Uri.parse('${uri}profile/address'),
        body: {
          "address": [
            {
              "addressName": addressName,
              "customerName": customerName,
              "phoneNumbers": phoneNumbers,
              "provinceLevel": {
                "province_id": provinceId,
                "province_name": provinceName
              },
              "districtLevel": {
                "district_id": districtId,
                "district_name": districtName,
              },
              "wardLevel": {
                "ward_code": wardCode,
                "ward_name": wardName,
              },
              "detail": detail,
            }
          ].toString()
        },
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBarSuccess(context, 'Thanh cong');
          });
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }

  Future<List<ProvinceLevel>> getProvinces(BuildContext context) async {
    final res = await http.get(Uri.parse('${uri}address/provinces'));
    List<ProvinceLevel> provinces = [];
    if (res.statusCode == 200) {
      List<dynamic> mapProvince = jsonDecode(res.body);
      if (!mapProvince.isNotEmpty) {
        throw Exception('Failed to load data');
      }

      for (int i = 0; i < mapProvince.length; i++) {
        if (mapProvince[i] != null) {
          provinces.add(ProvinceLevel.fromJson(mapProvince[i]));
        }
      }

      return provinces;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<DistrictLevel>> getDistricts(BuildContext context, int id) async {
    final res = await http.get(Uri.parse('${uri}address/districts/$id'));
    List<DistrictLevel> districtsLevel = [];
    if (res.statusCode == 200) {
      List<dynamic> mapDistricts = jsonDecode(res.body);
      if (!mapDistricts.isNotEmpty) {
        throw Exception('Failed to load data');
      }
      for (int i = 0; i < mapDistricts.length; i++) {
        if (mapDistricts[i] != null) {
          districtsLevel.add(DistrictLevel.fromJson(mapDistricts[i]));
        }
      }
      return districtsLevel;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<WardLevel>> getWards(BuildContext context, int id) async {
    final res = await http.get(Uri.parse('${uri}address/wards/$id'));
    List<WardLevel> wardLevel = [];
    if (res.statusCode == 200) {
      List<dynamic> mapWard = (jsonDecode(res.body));
      if (!mapWard.isNotEmpty) {
        throw Exception('Failed to load data');
      }
      for (int i = 0; i < mapWard.length; i++) {
        if (mapWard[i] != null) {
          wardLevel.add(WardLevel.fromJson(mapWard[i]));
        }
      }
      return wardLevel;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
