import 'package:flutter/material.dart';
import 'package:my_app/utils/constant.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({super.key, required this.text, required this.submit});
  String text;
  Function submit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        submit;
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(55),
        backgroundColor: primaryColors,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
