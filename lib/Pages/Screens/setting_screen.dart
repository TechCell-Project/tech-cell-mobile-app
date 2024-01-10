import 'package:flutter/material.dart';
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Pages/Tabs/login_tap.dart';
import 'package:my_app/Pages/Tabs/user_profile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: AuthLogin.getAccessToken(),
        builder: (context, snapshoot) {
          if (snapshoot.data == null) {
            return const LoginTap();
          } else {
            return const UserProfile();
          }
        },
      ),
    );
  }
}
