import 'package:flutter/material.dart';
import 'package:my_app/utils/constant.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: primaryColors,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Xem Thêm',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
