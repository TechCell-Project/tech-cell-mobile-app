import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primaryColors = Color(0xFFEE4949);
String uri = 'https://api.techcell.cloud/';

final formatCurrency =
    new NumberFormat.currency(locale: 'id', decimalDigits: 0, name: 'đ');

extension MyExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}
