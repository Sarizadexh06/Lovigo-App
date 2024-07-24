import 'package:flutter/material.dart';
import 'package:lovigoapp/modules/userInfo.dart';
import 'package:lovigoapp/screens/registerGender.dart';
import 'package:lovigoapp/styles.dart';

class RegisterInfo extends StatefulWidget {
  const RegisterInfo({super.key});

  @override
  State<RegisterInfo> createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: gradientDecoration,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: AppStyles.registerPagePadding,
                    child: Text(
                      'Register Page',
                      style: AppStyles.textStyleTitle,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(_firstNameController, 'First Name'),
                  SizedBox(height: 16),
                  _buildTextField(_lastNameController, 'Last Name'),
                  SizedBox(height: 16),
                  _buildTextField(_emailController, 'Email'),
                  SizedBox(height: 16),
                  _buildTextField(_phoneController, 'Phone Number', keyboardType: TextInputType.phone),
                  SizedBox(height: 16),
                  _buildTextField(_passwordController, 'Password', obscureText: true),
                  SizedBox(height: 43),
                  ElevatedButton(
                    onPressed: _onProceed,
                    child: Text('Proceed', style: AppStyles.textStyleForButton),
                    style: AppStyles.proceedButtonStyle,
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 110,
                          height: 110,
                          child: Image.asset('images/kalp.png')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.0),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: textFieldDecoration.copyWith(hintText: hintText),
      ),
    );
  }

  void _onProceed() {
    final userInfo = UserInfo(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterGender(userInfo: userInfo),
      ),
    );
  }
}
