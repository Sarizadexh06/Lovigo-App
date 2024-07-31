import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovigoapp/services/auth_service.dart';
import 'package:lovigoapp/services/user_service.dart';
import 'package:lovigoapp/modules/gender_module.dart';
import 'package:lovigoapp/modules/relationship_type.dart';
import 'package:lovigoapp/modules/zodiac_module.dart';
import 'package:lovigoapp/modules/education_level.dart';
import 'package:lovigoapp/modules/family_plan.dart';

class UserProfile extends StatefulWidget {
  final String accessToken;
  final Map<String, dynamic> userInfo;

  const UserProfile({Key? key, required this.accessToken, required this.userInfo}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthService authService = AuthService();
  final UserService userService = UserService();
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
  bool _isGenderLoading = true;
  bool _isZodiacLoading = true;
  bool _isRelationshipTypeLoading = true;
  bool _isEducationLevelLoading = true;
  bool _isFamilyPlanLoading = true;
  List<Gender> _genders = [];
  List<RelationshipType> _relationshipTypes = [];
  List<Zodiac> _zodiacs = [];
  List<EducationLevel> _educationLevels = [];
  List<FamilyPlan> _familyPlans = [];
  Gender? _selectedGender;
  RelationshipType? _selectedRelationshipType;
  Zodiac? _selectedZodiac;
  EducationLevel? _selectedEducationLevel;
  FamilyPlan? _selectedFamilyPlan;

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
    _loadData().then((_) {
      _loadUserInfo();
    });
  }

  Future<void> _loadUserInfo() async {
    final userInfo = widget.userInfo['data'];
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

        _selectedGender = _genders.firstWhere(
              (gender) => gender.name == userInfo['gender']?['name'],
          orElse: () => Gender(id: userInfo['gender']?['id'], name: userInfo['gender']?['name']),
        );
        _selectedRelationshipType = _relationshipTypes.firstWhere(
              (type) => type.name == userInfo['relationship_type']?['name'],
          orElse: () => RelationshipType(id: userInfo['relationship_type']?['id'], name: userInfo['relationship_type']?['name']),
        );
        _selectedZodiac = _zodiacs.firstWhere(
              (zodiac) => zodiac.name == userInfo['zodiac']?['name'],
          orElse: () => Zodiac(id: userInfo['zodiac']?['id'], name: userInfo['zodiac']?['name']),
        );
        _selectedEducationLevel = _educationLevels.firstWhere(
              (educationLevel) => educationLevel.name == userInfo['education_level']?['name'],
          orElse: () => EducationLevel(id: userInfo['education_level']?['id'], name: userInfo['education_level']?['name']),
        );
        _selectedFamilyPlan = _familyPlans.firstWhere(
              (familyPlan) => familyPlan.name == userInfo['family_plan']?['name'],
          orElse: () => FamilyPlan(id: userInfo['family_plan']?['id'], name: userInfo['family_plan']?['name']),
        );

        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load user info.')));
    }
  }

  Future<void> _loadData() async {
    try {
      final genders = await userService.fetchGenders();
      final relationshipTypes = await userService.fetchRelationshipTypes();
      final zodiacs = await userService.fetchZodiacs();
      final educationLevels = await userService.fetchEducationLevels();
      final familyPlans = await userService.fetchFamilyPlans();

      setState(() {
        _genders = genders;
        _relationshipTypes = relationshipTypes;
        _zodiacs = zodiacs;
        _educationLevels = educationLevels;
        _familyPlans = familyPlans;
        _isGenderLoading = false;
        _isRelationshipTypeLoading = false;
        _isZodiacLoading = false;
        _isEducationLevelLoading = false;
        _isFamilyPlanLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data')));
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

    final success = await authService.updateUserInfo(widget.accessToken,
        updatedData);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User information updated successfully.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user information.')),
      );
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
                  _buildExpansionTile('First Name', _firstNameController),
                  _buildExpansionTile('Last Name', _lastNameController),
                  _buildExpansionTile('Email', _emailController),
                  _buildExpansionTile('Phone', _phoneController),
                  _buildExpansionTile('Bio', _bioController),
                  buildSelectableExpansionTile<Gender>(
                    label: 'Gender',
                    controller: _genderController,
                    isLoading: _isGenderLoading,
                    items: _genders,
                    selectedItem: _selectedGender,
                    getItemName: (gender) => gender.name,
                    onSelect: (gender) {
                      setState(() {
                        _selectedGender = gender;
                        _genderController.text = gender.name;
                      });
                    },
                  ),
                  buildSelectableExpansionTile<RelationshipType>(
                    label: 'Relationship Type',
                    controller: _relationshipTypeController,
                    isLoading: _isRelationshipTypeLoading,
                    items: _relationshipTypes,
                    selectedItem: _selectedRelationshipType,
                    getItemName: (type) => type.name,
                    onSelect: (type) {
                      setState(() {
                        _selectedRelationshipType = type;
                        _relationshipTypeController.text = type.name;
                      });
                    },
                  ),
                  buildSelectableExpansionTile<Zodiac>(
                    label: 'Zodiac',
                    controller: _zodiacController,
                    isLoading: _isZodiacLoading,
                    items: _zodiacs,
                    selectedItem: _selectedZodiac,
                    getItemName: (zodiac) => zodiac.name,
                    onSelect: (zodiac) {
                      setState(() {
                        _selectedZodiac = zodiac;
                        _zodiacController.text = zodiac.name;
                      });
                    },
                  ),
                  buildSelectableExpansionTile<EducationLevel>(
                    label: 'Education Level',
                    controller: _educationLevelController,
                    isLoading: _isEducationLevelLoading,
                    items: _educationLevels,
                    selectedItem: _selectedEducationLevel,
                    getItemName: (educationLevel) => educationLevel.name,
                    onSelect: (educationLevel) {
                      setState(() {
                        _selectedEducationLevel = educationLevel;
                        _educationLevelController.text = educationLevel.name;
                      });
                    },
                  ),
                  buildSelectableExpansionTile<FamilyPlan>(
                    label: 'Family Plans',
                    controller: _familyPlanController,
                    isLoading: _isFamilyPlanLoading,
                    items: _familyPlans,
                    selectedItem: _selectedFamilyPlan,
                    getItemName: (familyPlan) => familyPlan.name,
                    onSelect: (familyPlan) {
                      setState(() {
                        _selectedFamilyPlan = familyPlan;
                        _familyPlanController.text = familyPlan.name;
                      });
                    },
                  ),
                  _buildExpansionTile('Communication Style', _communicationStyleController),
                  _buildExpansionTile('Pet Ownership', _petOwnershipController),
                  _buildExpansionTile('Drinking Habit', _drinkingHabitController),
                  _buildExpansionTile('Smoking Habit', _smokingHabitController),
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

  Widget _buildExpansionTile(String label, TextEditingController controller) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(label),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectableExpansionTile<T>({
    required String label,
    required TextEditingController controller,
    required bool isLoading,
    required List<T> items,
    required String Function(T) getItemName,
    required void Function(T) onSelect,
    T? selectedItem, // selectedItem parametresi eklendi
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(label),
        children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
            children: items.map((item) {
              return ListTile(
                title: Text(getItemName(item)),
                selected: selectedItem != null && selectedItem == item,
                selectedTileColor: Colors.grey[300], // Daha koyu renk
                selectedColor: Colors.black, // Seçili metin rengi
                onTap: () {
                  setState(() {
                    controller.text = getItemName(item);
                    onSelect(item);
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
