import 'package:flutter/material.dart';

class TitleWithMoreBtn extends StatelessWidget {
  final String text;
  const TitleWithMoreBtn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      child: Padding(
        padding: EdgeInsets.only(top: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
