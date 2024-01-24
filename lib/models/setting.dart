import 'package:flutter/cupertino.dart';
import 'package:my_app/Pages/Screens/home_screen.dart';
import 'package:my_app/Pages/Tabs/address_user.dart';
import 'package:my_app/Pages/Tabs/change_password.dart';
import 'package:my_app/Pages/Tabs/information_user.dart';
import 'package:my_app/Pages/Tabs/order_user.dart';

class SettingModel {
  String title;
  Widget route;
  IconData icon;

  SettingModel({required this.title, required this.route, required this.icon});
}

final List<SettingModel> settings = [
  SettingModel(
    title: 'Hồ sơ',
    route: const InformationUser(),
    icon: CupertinoIcons.person_fill,
  ),
  SettingModel(
    title: 'Đổi mật khẩu',
    route: const ChangePassword(),
    icon: CupertinoIcons.doc_fill,
  ),
  SettingModel(
    title: 'Địa chỉ',
    route: const AddressUser(),
    icon: CupertinoIcons.location,
  ),
  SettingModel(
    title: 'Đơn hàng của bạn',
    route: const OrderUserTap(),
    icon: CupertinoIcons.shopping_cart,
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
