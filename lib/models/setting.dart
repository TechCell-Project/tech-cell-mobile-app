import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Screens/home_screen.dart';

class SettingModel {
  String title;
  Widget route;
  IconData icon;

  SettingModel({required this.title, required this.route, required this.icon});
}

final List<SettingModel> settings = [
  SettingModel(
    title: 'Person Data',
    route: const HomeScreen(),
    icon: CupertinoIcons.person_fill,
  ),
  SettingModel(
    title: 'Setting',
    route: const HomeScreen(),
    icon: Icons.settings,
  ),
  SettingModel(
    title: 'E-statement',
    route: const HomeScreen(),
    icon: CupertinoIcons.doc_fill,
  ),
  SettingModel(
    title: 'Refferal Code',
    route: const HomeScreen(),
    icon: CupertinoIcons.heart_fill,
  ),
];
final List<SettingModel> settings2 = [
  SettingModel(
    title: 'FQA',
    route: const HomeScreen(),
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
  ),
  SettingModel(
    title: 'Our handBox',
    route: const HomeScreen(),
    icon: CupertinoIcons.pencil_circle_fill,
  ),
  SettingModel(
    title: 'Community',
    route: const HomeScreen(),
    icon: CupertinoIcons.person_3_fill,
  ),
];
