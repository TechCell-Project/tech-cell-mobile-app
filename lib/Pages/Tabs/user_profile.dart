import 'package:flutter/material.dart';
import 'package:my_app/API/api_login.dart';
import 'package:my_app/API/api_profile.dart';
import 'package:my_app/Providers/token_manager.dart';

import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/Widgets/SettingScreen/setting_title.dart';
import 'package:my_app/models/setting.dart';
import 'package:my_app/models/user_model.dart';
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
  void initState() {
    ProfileUser().getProfileUser(context);
    TokenManager.getUserfromStorage();
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    await ProfileUser().getProfileUser(context);
    TokenManager.getUserfromStorage();
    return Future.delayed(Duration(seconds: 4));
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context, listen: false).user;
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
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                        color: primaryColors.withOpacity(0.3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        // backgroundImage: AssetImage('assets/icons/profile.png'),
                        backgroundImage: user.avatar.url.isEmpty
                            ? const AssetImage('assets/icons/profile.png')
                            : NetworkImage(user.avatar.url) as ImageProvider,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.firstName} ${user.lastName}',
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
                      ),
                    ),
                  ),
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
                ButtonSendrequest(
                    text: 'Đăng xuất', submit: () => signOutUser(context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
