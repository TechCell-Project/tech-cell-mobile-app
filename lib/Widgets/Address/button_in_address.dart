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
      child: ElevatedButton(
        onPressed: functionAddress,
        style: ElevatedButton.styleFrom(
          minimumSize:  Size.fromHeight(55),
          backgroundColor: primaryColors,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          textInAddress,
          style:  TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
