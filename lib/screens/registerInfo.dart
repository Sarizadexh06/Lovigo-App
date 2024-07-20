import 'package:flutter/material.dart';
import 'package:lovigoapp/screens/registerGender.dart';
import '../styles.dart';

class RegisterInfo extends StatefulWidget {
  const RegisterInfo({super.key});

  @override
  State<RegisterInfo> createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              SizedBox(height:20),
              _buildTextField(_nameController, 'Name'),
              SizedBox(height: 16),
              _buildTextField(_emailController, 'Email'),
              SizedBox(height: 16),
              _buildTextField(_phoneController, 'Phone Number',
                  keyboardType: TextInputType.phone),
              SizedBox(height: 16),
              _buildTextField(_passwordController, 'Password',
                  obscureText: true),
              SizedBox(height: 16),
              _buildTextField(_confirmPasswordController, 'Confirm Password',
                  obscureText: true),
              SizedBox(height: 43),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterGender(),
                        ));
                  });
                },
                child: Text(' Proceed ', style: AppStyles.textStyleForButton, ),
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
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool obscureText = false,
        TextInputType keyboardType = TextInputType.text}) {
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

  void _onRegister() {
    // Handle the registration logic here
  }
}
