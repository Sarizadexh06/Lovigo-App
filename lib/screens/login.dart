import 'package:flutter/material.dart';
import 'package:lovigoapp/screens/registerInfo.dart';

import 'package:lovigoapp/screens/registerInterests.dart';
import '../styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'userMainPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String textForWelcome = 'Welcome To Lovigo';
  final String textForLogin = 'Login';
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
                  boxShadow: [
                    /*      BoxShadow(
                      color:
                          Color.fromARGB(255, 133, 186, 242).withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ), */
                  ],
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
                child: Container(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Username',
                          prefixIcon: const Icon(Icons.person),
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
                      SizedBox(height: 20),
                      TextFormField(
                        textAlign: TextAlign.start,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
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
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UserMainPage()));
                          },
                          child: Text(
                            textForLogin,
                            style: GoogleFonts.greatVibes(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 199, 119, 225),
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
                                  builder: (context) =>
                                  const RegisterInfo()),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
