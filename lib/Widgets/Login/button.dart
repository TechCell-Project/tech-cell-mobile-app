import 'package:flutter/material.dart';
import 'package:my_app/utils/constant.dart';

// ignore: must_be_immutable
class ButtonSendrequest extends StatelessWidget {
  ButtonSendrequest({super.key, required this.text, required this.submit});
  String text;
  Function() submit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: submit,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(55),
        backgroundColor: primaryColors,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
