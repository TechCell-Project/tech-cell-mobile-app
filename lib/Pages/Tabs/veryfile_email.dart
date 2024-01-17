import 'package:flutter/material.dart';
import 'package:my_app/API/api_sign_up.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/utils/constant.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController otpController = TextEditingController();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  void sendOtpVerifyemail() {
    AuthSignUp().verifyEmail(
      context: context,
      otp: otpController.text,
      email: widget.email,
    );
  }

  void resentOtpEmail() {
    AuthSignUp().resentOtpVerifyEmail(
      context: context,
      email: widget.email,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: primaryColors,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Nhập mã OTP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              const Text(
                'Vui lòng nhập mã OTP đã được gửi đến email của bạn để chúng tôi tiến hành xác thực email ',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 60,
              ),
              TextFieldPin(
                textController: otpController,
                autoFocus: false,
                codeLength: 6,
                alignment: MainAxisAlignment.center,
                defaultBoxSize: 40.0,
                margin: 10,
                selectedBoxSize: 42.0,
                textStyle: const TextStyle(fontSize: 16),
                defaultDecoration: _pinPutDecoration.copyWith(
                    border: Border.all(
                        color:
                            Theme.of(context).primaryColor.withOpacity(0.6))),
                selectedDecoration: _pinPutDecoration,
                onChange: (code) {
                  setState(() {});
                },
              ),
              Row(
                children: [
                  const Text(
                    'Nếu bạn chưa nhận được mã OTP thì nhấn',
                  ),
                  TextButton(
                    onPressed: resentOtpEmail,
                    child: const Text('Vào đây'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ButtonSendrequest(
                text: 'Xác thực Email',
                submit: sendOtpVerifyemail,
              )
            ],
          ),
        ),
      ),
    );
  }
}
