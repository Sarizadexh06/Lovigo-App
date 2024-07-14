import 'package:flutter/material.dart';
import 'package:lovigoapp/styles.dart';

import 'login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gradientDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(45),
              child: Image.asset("images/lovigoApp-logo.png"),
            ),
            Text('Lovigo', style: AppStyles.registerPageTitleStyle),
            SizedBox(height: 20.0),
            LoginCard(
              icon: Icons.facebook,
              text: 'Continue with Facebook',
              color: Colors.blue,
              onPressed: () {
                // Facebook login logic
              },
            ),

            LoginCard(
              icon: Icons.g_mobiledata_rounded,
              text: 'Continue with Google',
              color: Colors.deepOrange,
              onPressed: () {
                // Google login logic
              },
            ),

            LoginCard(
              icon: Icons.account_circle,
              text: 'Continue with Lovigo',
              color: Colors.deepPurple,
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(),));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const LoginCard({
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, color: color, size: 30.0),
                SizedBox(width: 20.0),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
