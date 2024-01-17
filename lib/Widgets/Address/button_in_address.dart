import 'package:flutter/material.dart';
import 'package:my_app/utils/constant.dart';

// ignore: must_be_immutable
class ButtonInAddress extends StatelessWidget {
  String textInAddress;
  Function() functionAddress;
  ButtonInAddress(
      {super.key, required this.functionAddress, required this.textInAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ElevatedButton(
        onPressed: functionAddress,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(55),
          backgroundColor: primaryColors,
        ),
        child: Text(
          textInAddress,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
