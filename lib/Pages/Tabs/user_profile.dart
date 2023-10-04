import 'package:flutter/material.dart';
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/SettingScreen/setting_title.dart';
import 'package:my_app/models/setting.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  void signOutUser(BuildContext context) {
    AuthLogin().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/profile.png',
                        width: 50,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.userName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            user.email,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColors),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                      children: List.generate(
                          settings.length,
                          (index) => SettingTitle(
                                settings: settings[index],
                              ))),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColors),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                      children: List.generate(
                          settings2.length,
                          (index) => SettingTitle(
                                settings: settings2[index],
                              ))),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => signOutUser(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(55),
                    backgroundColor: primaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Đăng xuat',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
