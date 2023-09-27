import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/models/setting.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({super.key, required this.settings});
  final SettingModel settings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => settings.route));
        },
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColors.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                settings.icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              settings.title,
              style: const TextStyle(
                color: Color.fromARGB(255, 136, 136, 136),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.chevron_forward,
              color: primaryColors.withOpacity(0.8),
            )
          ],
        ),
      ),
    );
  }
}
