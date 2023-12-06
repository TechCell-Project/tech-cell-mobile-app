import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/API/api_veryfi.dart';
import 'package:my_app/utils/constant.dart';

class ForgotTap extends StatefulWidget {
  const ForgotTap({super.key});

  @override
  State<ForgotTap> createState() => _ForgotTapState();
}

class _ForgotTapState extends State<ForgotTap> {
  final TextEditingController emailController = TextEditingController();
  bool clrButton = false;
  Verify verify = Verify();

  void sentOTP() {
    verify.forgotPassword(
      context: context,
      email: emailController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Quen Mat Khau',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Nhap dia chi email de nhan ma OTP',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                onChanged: (val) {
                  if (val != "") {
                    setState(() {
                      clrButton = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Email",
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        emailController.clear();
                      });
                    },
                    child: const Icon(
                      CupertinoIcons.multiply,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: sentOTP,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(55),
                  backgroundColor: primaryColors,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Gui Ma OTP',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
