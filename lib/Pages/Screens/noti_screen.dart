import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/login_tap.dart';
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
            return Scaffold(
              appBar: AppBar(
                title: Center(child: Text('Thông báo')),
              ),
              body: Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.grey,
                      ),
                      Text('Vui lòng đăng nhập để xem thông báo')
                    ],
                  ),
                ),
              ),
            );
          } else {
            return NotificationAfterLoginTab();
          }
        },
      ),
    );
  }
}
