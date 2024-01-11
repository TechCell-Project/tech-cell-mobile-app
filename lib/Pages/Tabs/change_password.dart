import 'package:flutter/material.dart';
import 'package:my_app/API/api_profile.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/utils/validator.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController reNewPassword = TextEditingController();
  ProfileUser changePassword = ProfileUser();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showOldPassword = true;
  bool _showNewPassword = true;
  bool _showReNewPassword = true;

  void changeUserPassword() {
    if (_formKey.currentState!.validate()) {
      changePassword.changePassword(
        context: context,
        oldPassword: oldPassword.text.trim(),
        newPassword: newPassword.text.trim(),
        reNewPassword: reNewPassword.text.trim(),
      );
    }
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Thay đổi mật khẩu ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: _showOldPassword,
                          validator: (value) =>
                              Validator.validatePassword(value ?? ''),
                          controller: oldPassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Mật khẩu cũ",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showOldPassword = !_showOldPassword;
                                });
                              },
                              child: Icon(
                                _showOldPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: _showNewPassword,
                          validator: (value) =>
                              Validator.validatePassword(value ?? ''),
                          controller: newPassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Mật khẩu mới",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showNewPassword = !_showNewPassword;
                                });
                              },
                              child: Icon(
                                _showNewPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: _showReNewPassword,
                          validator: (value) =>
                              Validator.validatePassword(value ?? ''),
                          controller: reNewPassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Nhập lại mật khẩu",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showReNewPassword = !_showReNewPassword;
                                });
                              },
                              child: Icon(
                                _showReNewPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 50),
              ButtonSendrequest(text: 'Đổi mật khẩu', submit: changeUserPassword),
              
            ],
          ),
        ),
      ),
    );
  }
}
