import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Screens/cart_screen.dart';
import 'package:my_app/Pages/Screens/home_screen.dart';
import 'package:my_app/Pages/Screens/noti_screen.dart';
import 'package:my_app/Pages/Screens/setting_screen.dart';
import 'package:my_app/utils/constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> page = [
    const HomeScreen(),
    const CartScreen(),
    const NotiScreen(),
    const SettingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: page,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          CupertinoIcons.home,
          CupertinoIcons.cart,
          CupertinoIcons.bell,
          CupertinoIcons.profile_circled
        ],
        leftCornerRadius: 25,
        rightCornerRadius: 25,
        gapLocation: GapLocation.none,
        inactiveColor: Colors.grey,
        activeColor: primaryColors,
        activeIndex: pageIndex,
        iconSize: 25,
        onTap: (p0) {
          setState(() {
            pageIndex = p0;
          });
        },
      ),
    );
  }
}
