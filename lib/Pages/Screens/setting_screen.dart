import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/login_tap.dart';
import 'package:my_app/Pages/Tabs/sigup_tap.dart';
import 'package:my_app/Widgets/SettingScreen/setting_title.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/models/setting.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginTap()));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColors,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Đăng Nhập',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpTap()));
                  },
                  child: const Text('Đăng ký',
                      style: TextStyle(
                          color: Color.fromARGB(255, 128, 128, 128),
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
