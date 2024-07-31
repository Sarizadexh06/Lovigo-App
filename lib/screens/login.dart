import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovigoapp/screens/registerInfo.dart';
import 'package:lovigoapp/screens/userMainPage.dart';
import 'package:lovigoapp/services/auth_service.dart';

import '../styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  void _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Email and password cannot be empty.';
      });
      return;
    }

    final loginData = await authService.login(
      emailController.text,
      passwordController.text,
    );

    if (loginData != null && loginData['access_token'] != null) {
      final token = loginData['access_token'];
      final userInfo = await authService.getUserInfo(token);
      if (userInfo != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserMainPage(accessToken: token, userInfo: userInfo)),
        );
      } else {
        setState(() {
          errorMessage = 'Failed to retrieve user info.';
        });
      }
    } else {
      setState(() {
        errorMessage = 'Login failed. Please check your email and password.';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gradientDecoration,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 120),
              Container(
                width: 240,
                height: 240,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'images/lovigoApp-logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120, left: 30, right: 30),
                child: Column(
                  children: [
                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                      ),
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      textAlign: TextAlign.start,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                      ),
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _login,
                        child: Text(
                          'Login',
                          style: GoogleFonts.greatVibes(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 199, 119, 225),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterInfo()),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 200, 64, 210),
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'Register now!',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 72, 156, 225),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
