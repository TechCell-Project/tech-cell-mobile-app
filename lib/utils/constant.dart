import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primaryColors = Color.fromARGB(255, 248, 149, 142);
String uri = 'https://api.techcell.cloud/';

final formatCurrency =
    new NumberFormat.currency(locale: 'id', decimalDigits: 0, name: 'đ');

extension MyExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}
