import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_app/Pages/Screens/favorite_screen.dart';
import 'package:my_app/Pages/Screens/home_screen.dart';
import 'package:my_app/Pages/Screens/noti_screen.dart';
import 'package:my_app/Pages/Screens/setting_screen.dart';
import 'package:my_app/utils/constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    FavoriteScreen(),
    NotiScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: GNav(
            gap: 4,
            backgroundColor: Colors.white.withOpacity(0.8),
            color: Colors.black.withOpacity(0.6),
            activeColor: primaryColors,
            tabBackgroundColor: Colors.grey.shade300,
            padding: EdgeInsets.all(16),
            iconSize: 22,
            onTabChange: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Trang chủ',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Yêu thích',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Thông báo',
              ),
              GButton(
                icon: Icons.account_circle_sharp,
                text: 'Tôi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
