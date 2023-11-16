import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/login_tap.dart';
import 'package:my_app/Pages/Tabs/user_profile.dart';
import 'package:my_app/Providers/user_provider.dart';

import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<UserProvider>(context).user.accessToken.isEmpty
          ? const LoginTap()
          : const UserProfile(),
    );
  }
}
