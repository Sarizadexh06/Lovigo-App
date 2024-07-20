import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovigoapp/screens/registerInterests.dart';
import '../styles.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterGender extends StatefulWidget {
  const RegisterGender({super.key});

  @override
  State<RegisterGender> createState() => _RegisterGenderState();
}

class _RegisterGenderState extends State<RegisterGender> {
  String? _selectedGender;
  void _proceedToNextPage() {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterInterests()),
    );
  }

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
              padding: AppStyles.registerPagePadding,
              child: Text(
                'Register Gender',
                style: AppStyles.textStyleTitle,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,
              onPressed: () {
                setState(() {
                  _selectedGender = 'Male';
                });
              },
              child: Text('Male'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,
              onPressed: () {
                setState(() {
                  _selectedGender = 'Female';
                });
              },
              child: Text('Female'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,
              onPressed: () {
                setState(() {
                  _selectedGender = 'Other';
                });
              },
              child: Text('Other'),
            ),
            SizedBox(height: 20),
            if (_selectedGender != null)
              Text(
                'Selected Gender: $_selectedGender',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: 20,),
            if (_selectedGender != null)
              Padding(
                padding: EdgeInsets.only(top: 35),
                child: ElevatedButton(
                  style: AppStyles.proceedButtonStyle,
                  onPressed: _proceedToNextPage,
                  child: Text('Proceed',style: AppStyles.textStyleForButton,),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
