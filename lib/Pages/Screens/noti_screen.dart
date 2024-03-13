import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/notification_after_login_tab.dart';
import 'package:my_app/Providers/token_manager.dart';
import 'package:my_app/models/user_model.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        future: TokenManager.getUserfromStorage(),
        builder: (context, snapshoot) {
          if (snapshoot.data == null) {
            return Container();
          } else {
            return NotificationAfterLoginTab();
          }
        },
      ),
    );
  }
}
