import 'package:flutter/material.dart';
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Pages/Tabs/forgot_tap.dart';
import 'package:my_app/Pages/Tabs/sigup_tap.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/Widgets/Login/button_login.dart';
import 'package:my_app/utils/validator.dart';

class LoginTap extends StatefulWidget {
  const LoginTap({super.key});

  @override
  State<LoginTap> createState() => _LoginTapState();
}

class _LoginTapState extends State<LoginTap> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailOrUserName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final AuthLogin authLogin = AuthLogin();
  bool _showPassword = true;

  void loginUser() {
    if (_formKey.currentState!.validate()) {
      authLogin.loginUser(
        context: context,
        emailOrUsername: emailOrUserName.text.trim(),
        password: password.text.trim(),
      );
    }
  }

  void signinGoogle() {
    authLogin.signInWithGoogle(context: context);
    // authLogin.signOut(context);
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
                        controller: emailOrUserName,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (value) =>
                            Validator.validatePassword(value ?? ''),
                        controller: password,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
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
                              size: 25,
                            ),
                          ),
                          isDense: true,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ForgotTap()));
                          },
                          child: const Text(
                            'Quên Mật Khẩu?',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ButtonSendrequest(text: 'Đăng nhập', submit: loginUser),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Bạn chưa có tài khoản?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpTap(),
                                  ));
                            },
                            child: const Text(
                              'Đăng ký',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Text(
                            'Hoặc',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      ButtonLogin(
                        loginWith: signinGoogle,
                        image: 'assets/icons/google.png',
                        text: 'Đăng nhập bằng Google',
                      ),
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
