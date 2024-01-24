// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class AddressModel {
  final String addressName;
  final String customerName;
  final String phoneNumbers;
  final ProvinceLevel provinceLevel;
  final DistrictLevel districtLevel;
  final WardLevel wardLevel;
  final String detail;
  bool isDefault;

  AddressModel({
    required this.addressName,
    required this.customerName,
    required this.phoneNumbers,
    required this.provinceLevel,
    required this.districtLevel,
    required this.wardLevel,
    required this.detail,
    required this.isDefault,
  });

  factory AddressModel.fromRawJson(String str) =>
      AddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        addressName: json["addressName"],
        customerName: json["customerName"],
        phoneNumbers: json["phoneNumbers"],
        provinceLevel: ProvinceLevel.fromJson(json["provinceLevel"]),
        districtLevel: DistrictLevel.fromJson(json["districtLevel"]),
        wardLevel: WardLevel.fromJson(json["wardLevel"]),
        detail: json["detail"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "addressName": addressName,
        "customerName": customerName,
        "phoneNumbers": phoneNumbers,
        "provinceLevel": provinceLevel.toJson(),
        "districtLevel": districtLevel.toJson(),
        "wardLevel": wardLevel.toJson(),
        "detail": detail,
        "isDefault": isDefault,
      };

  toMap() {}

  static fromMap(Map<String, dynamic> map) {}
}

class DistrictLevel {
  final int district_id;
  final String district_name;

  DistrictLevel({
    required this.district_id,
    required this.district_name,
  });

  factory DistrictLevel.fromRawJson(String str) =>
      DistrictLevel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DistrictLevel.fromJson(Map<String, dynamic> json) => DistrictLevel(
        district_id: json["district_id"] as int,
        district_name: json["district_name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "district_id": district_id,
        "district_name": district_name,
      };
}

class ProvinceLevel {
  final int province_id;
  final String province_name;

  ProvinceLevel({
    required this.province_id,
    required this.province_name,
  });

  factory ProvinceLevel.fromRawJson(String str) =>
      ProvinceLevel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProvinceLevel.fromJson(Map<String, dynamic> json) => ProvinceLevel(
        province_id: json["province_id"] as int,
        province_name: json["province_name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "province_id": province_id,
        "province_name": province_name,
      };
}

class WardLevel {
  final String wardCode;
  final String wardName;

  WardLevel({
    required this.wardCode,
    required this.wardName,
  });

  factory WardLevel.fromRawJson(String str) =>
      WardLevel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WardLevel.fromJson(Map<String, dynamic> json) => WardLevel(
        wardCode: json["ward_code"],
        wardName: json["ward_name"],
      );

  Map<String, dynamic> toJson() => {
        "ward_code": wardCode,
        "ward_name": wardName,
      };
}
