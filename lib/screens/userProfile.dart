import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovigoapp/services/auth_service.dart';

class UserProfile extends StatefulWidget {
  final String accessToken;
  final Map<String, dynamic> userInfo;

  const UserProfile({Key? key, required this.accessToken, required this.userInfo}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthService authService = AuthService();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _genderController;
  late TextEditingController _relationshipTypeController;
  late TextEditingController _zodiacController;
  late TextEditingController _educationLevelController;
  late TextEditingController _familyPlanController;
  late TextEditingController _communicationStyleController;
  late TextEditingController _petOwnershipController;
  late TextEditingController _drinkingHabitController;
  late TextEditingController _smokingHabitController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _bioController = TextEditingController();
    _genderController = TextEditingController();
    _relationshipTypeController = TextEditingController();
    _zodiacController = TextEditingController();
    _educationLevelController = TextEditingController();
    _familyPlanController = TextEditingController();
    _communicationStyleController = TextEditingController();
    _petOwnershipController = TextEditingController();
    _drinkingHabitController = TextEditingController();
    _smokingHabitController = TextEditingController();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final userInfo = widget.userInfo['data'];  // 'data' anahtarını ekledik
    if (userInfo != null) {
      setState(() {
        _firstNameController.text = userInfo['first_name'] ?? '';
        _lastNameController.text = userInfo['last_name'] ?? '';
        _emailController.text = userInfo['email'] ?? '';
        _phoneController.text = userInfo['phone'] ?? '';
        _bioController.text = userInfo['bio'] ?? '';
        _genderController.text = userInfo['gender']?['name'] ?? '';
        _relationshipTypeController.text = userInfo['relationship_type']?['name'] ?? '';
        _zodiacController.text = userInfo['zodiac']?['name'] ?? '';
        _educationLevelController.text = userInfo['education_level']?['name'] ?? '';
        _familyPlanController.text = userInfo['family_plan']?['name'] ?? '';
        _communicationStyleController.text = userInfo['communication_style']?['name'] ?? '';
        _petOwnershipController.text = userInfo['pet_ownership']?['name'] ?? '';
        _drinkingHabitController.text = userInfo['drinking_habit']?['name'] ?? '';
        _smokingHabitController.text = userInfo['smoking_habit']?['name'] ?? '';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load user info.')));
    }
  }

  Future<void> _updateUserInfo() async {
    final updatedData = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'gender': {'name': _genderController.text},
      'relationship_type': {'name': _relationshipTypeController.text},
      'zodiac': {'name': _zodiacController.text},
      'education_level': {'name': _educationLevelController.text},
      'family_plan': {'name': _familyPlanController.text},
      'communication_style': {'name': _communicationStyleController.text},
      'pet_ownership': {'name': _petOwnershipController.text},
      'drinking_habit': {'name': _drinkingHabitController.text},
      'smoking_habit': {'name': _smokingHabitController.text},
    };

    final success = await authService.updateUserInfo(widget.accessToken, updatedData);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User information updated successfully.')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update user information.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/lovigoApp-logo.png",
              fit: BoxFit.contain,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.purpleAccent.withOpacity(0.3),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('First Name', _firstNameController),
                  _buildTextField('Last Name', _lastNameController),
                  _buildTextField('Email', _emailController),
                  _buildTextField('Phone', _phoneController),
                  _buildTextField('Bio', _bioController),
                  _buildTextField('Gender', _genderController),
                  _buildTextField('Relationship Type', _relationshipTypeController),
                  _buildTextField('Zodiac', _zodiacController),
                  _buildTextField('Education Level', _educationLevelController),
                  _buildTextField('Family Plan', _familyPlanController),
                  _buildTextField('Communication Style', _communicationStyleController),
                  _buildTextField('Pet Ownership', _petOwnershipController),
                  _buildTextField('Drinking Habit', _drinkingHabitController),
                  _buildTextField('Smoking Habit', _smokingHabitController),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _updateUserInfo,
                    child: Text('Update Info'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
