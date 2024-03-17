import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/login_tap.dart';
import 'package:my_app/Pages/Tabs/user_profile.dart';
import 'package:my_app/Providers/token_manager.dart';
import 'package:my_app/models/user_models.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        future: TokenManager.getUserfromStorage(),
        builder: (context, snapshoot) {
          if (snapshoot.data == null) {
            return LoginTap();
          } else {
            return UserProfile();
          }
        },
      ),
    );
  }
}
