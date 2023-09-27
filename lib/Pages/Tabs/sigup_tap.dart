import 'package:flutter/material.dart';
import 'package:my_app/API/api_sign_up.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/validator.dart';

class SignUpTap extends StatefulWidget {
  const SignUpTap({super.key});

  @override
  State<SignUpTap> createState() => _SignUpTapState();
}

class _SignUpTapState extends State<SignUpTap> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final AuthSignUp authSignUp = AuthSignUp();
  bool _showPassword = true;
  bool _showRePassword = true;

  void signUpUser() {
    if (_formKey.currentState!.validate()) {
      authSignUp.signUpUser(
        context: context,
        email: email.text,
        userName: userName.text,
        firstName: firstName.text,
        lastName: lastName.text,
        password: password.text,
        rePassword: rePassword.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/logos/logo-red.png'),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) =>
                            Validator.validateText(value ?? ''),
                        controller: firstName,
                        decoration: const InputDecoration(
                          labelText: 'Fisrt Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (value) =>
                            Validator.validateText(value ?? ''),
                        controller: lastName,
                        decoration: const InputDecoration(
                          labelText: 'LastName',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (value) =>
                            Validator.validateEmail(value ?? ''),
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.mail),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (value) =>
                            Validator.validateText(value ?? ''),
                        controller: userName,
                        decoration: const InputDecoration(
                          labelText: 'Tên đăng nhập',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (value) =>
                            Validator.validatePassword(value ?? ''),
                        controller: password,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                          labelText: 'Mật Khẩu',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword
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
                        validator: (value) =>
                            Validator.validatePassword(value ?? ''),
                        controller: rePassword,
                        obscureText: _showRePassword,
                        decoration: InputDecoration(
                          labelText: 'Xác Nhận Mật khẩu',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showRePassword = !_showRePassword;
                              });
                            },
                            child: Icon(
                              _showRePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: signUpUser,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(55),
                          backgroundColor: primaryColors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Đăng ký',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
