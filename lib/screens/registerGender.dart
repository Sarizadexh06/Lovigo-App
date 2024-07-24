import 'package:flutter/material.dart';
import 'package:lovigoapp/modules/gender_module.dart';
import 'package:lovigoapp/modules/userInfo.dart';
import 'package:lovigoapp/screens/registerInterests.dart';
import 'package:lovigoapp/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lovigoapp/styles.dart';

class RegisterGender extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterGender({super.key, required this.userInfo});

  @override
  State<RegisterGender> createState() => _RegisterGenderState();
}

class _RegisterGenderState extends State<RegisterGender> {
  String? _selectedGender;
  int? _selectedGenderId;
  List<Gender> _genders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGenders();
  }

  Future<void> _fetchGenders() async {
    final response = await http.get(Uri.parse('https://lovigo.net/genders'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        _genders = jsonResponse.map((gender) => Gender.fromJson(gender)).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load genders');
    }
  }

  void _onProceed() async {
    if (_selectedGenderId != null) {
      widget.userInfo.genderId = _selectedGenderId;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterInterests(userInfo: widget.userInfo),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a gender')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: gradientDecoration,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
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
                ..._genders.map((gender) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    style: AppStyles.elevatedButtonStyle,
                    onPressed: () {
                      setState(() {
                        _selectedGender = gender.name;
                        _selectedGenderId = gender.id;
                      });
                    },
                    child: Text(gender.name),
                  ),
                )),
                if (_selectedGender != null)
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Selected Gender: $_selectedGender',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: ElevatedButton(
                          style: AppStyles.proceedButtonStyle,
                          onPressed: _onProceed,
                          child: Text(
                            'Proceed',
                            style: AppStyles.textStyleForButton,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
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
}
