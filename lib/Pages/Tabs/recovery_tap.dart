import 'package:flutter/material.dart';
import 'package:my_app/API/api_veryfi.dart';
import 'package:my_app/utils/constant.dart';

// ignore: must_be_immutable
class RecoveryTap extends StatelessWidget {
  String email;
  RecoveryTap({super.key, required this.email, required this.context});
  BuildContext context;

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwrordController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController re_passwordController = TextEditingController();
  bool clrButton = false;
  Verify verify = Verify();
  bool _showPassword = true;
  bool _showRePassword = true;

  void changePassword() {
    verify.verifyForgotPassword(
      context: context,
      email: email,
      otpCode: otpController.text,
      password: passwrordController.text,
      re_password: re_passwordController.text,
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
                'Thay doi Mat khau ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: otpController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ma OTP",
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: _showPassword,
                controller: passwrordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Mat khau Moi",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: _showRePassword,
                controller: re_passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Nhap lai Mat khau",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showRePassword = !_showRePassword;
                      });
                    },
                    child: Icon(
                      _showRePassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: changePassword,
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

  void setState(Null Function() param0) {}
}
