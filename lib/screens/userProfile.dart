import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovigoapp/modules/smoking_habit.dart';
import 'package:lovigoapp/services/auth_service.dart';
import 'package:lovigoapp/services/user_service.dart';
import 'package:lovigoapp/modules/gender_module.dart';
import 'package:lovigoapp/modules/relationship_type.dart';
import 'package:lovigoapp/modules/zodiac_module.dart';
import 'package:lovigoapp/modules/education_level.dart';
import 'package:lovigoapp/modules/family_plan.dart';
import 'package:lovigoapp/modules/communication_style.dart';
import 'package:lovigoapp/modules/pet_ownership.dart';
import 'package:lovigoapp/modules/drinking_habit.dart';

class UserProfile extends StatefulWidget {
  final String accessToken;
  final Map<String, dynamic> userInfo;

  const UserProfile({Key? key, required this.accessToken, required this.userInfo}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Map<String, dynamic> userInfo;
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
  bool _isCommunicationStyleLoading = true;
  bool _isPetOwnershipLoading = true;
  bool _isDrinkingHabitLoading = true;
  bool _isSmokingHabitLoading = true;
  List<Gender> _genders = [];
  List<RelationshipType> _relationshipTypes = [];
  List<Zodiac> _zodiacs = [];
  List<EducationLevel> _educationLevels = [];
  List<FamilyPlan> _familyPlans = [];
  List<CommunicationStyle> _communicationStyles = [];
  List<PetOwnership> _petOwnerships = [];
  List<DrinkingHabits> _drinkingHabits = [];
  List<SmokingHabit> _smokingHabits = [];
  Gender? _selectedGender;
  RelationshipType? _selectedRelationshipType;
  Zodiac? _selectedZodiac;
  EducationLevel? _selectedEducationLevel;
  FamilyPlan? _selectedFamilyPlan;
  CommunicationStyle? _selectedCommunicationStyle;
  PetOwnership? _selectedPetOwnership;
  DrinkingHabits? _selectedDrinkingHabit;
  SmokingHabit? _selectedSmokingHabit;

  @override
  void initState() {
    super.initState();
    userInfo = widget.userInfo;
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
        _selectedCommunicationStyle = _communicationStyles.firstWhere(
              (communicationStyle) => communicationStyle.name == userInfo['communication_style']?['name'],
          orElse: () => CommunicationStyle(id: userInfo['communication_style']?['id'], name: userInfo['communication_style']?['name']),
        );
        _selectedPetOwnership = _petOwnerships.firstWhere(
              (petOwnership) => petOwnership.name == userInfo['pet_ownership']?['name'],
          orElse: () => PetOwnership(
            id: userInfo['pet_ownership']?['id'] ?? -1,
            name: userInfo['pet_ownership']?['name'] ?? '',
          ),
        );
        _selectedDrinkingHabit = _drinkingHabits.firstWhere(
              (drinkingHabit) => drinkingHabit.name == userInfo['drinking_habit']?['name'],
          orElse: () => DrinkingHabits(
            id: userInfo['drinking_habit']?['id'] ?? -1,
            name: userInfo['drinking_habit']?['name'] ?? '',
          ),
        );
        _selectedSmokingHabit = _smokingHabits.firstWhere(
              (smokingHabit) => smokingHabit.name == userInfo['smoking_habit']?['name'],
          orElse: () => SmokingHabit(
            id: userInfo['smoking_habit']?['id'] ?? -1,
            name: userInfo['smoking_habit']?['name'] ?? '',
          ),
        );

        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user info.')),
      );
    }
  }

  Future<void> _loadData() async {
    try {
      final genders = await userService.fetchGenders();
      final relationshipTypes = await userService.fetchRelationshipTypes();
      final zodiacs = await userService.fetchZodiacs();
      final educationLevels = await userService.fetchEducationLevels();
      final familyPlans = await userService.fetchFamilyPlans();
      final communicationStyles = await userService.fetchCommunicationStyles();
      final petOwnerships = await userService.fetchPetOwnerships();
      final drinkingHabits = await userService.fetchDrinkingHabits();
      final smokingHabits = await userService.fetchSmokingHabits();

      setState(() {
        _genders = genders;
        _relationshipTypes = relationshipTypes;
        _zodiacs = zodiacs;
        _educationLevels = educationLevels;
        _familyPlans = familyPlans;
        _communicationStyles = communicationStyles;
        _petOwnerships = petOwnerships;
        _drinkingHabits = drinkingHabits;
        _smokingHabits = smokingHabits;
        _isGenderLoading = false;
        _isRelationshipTypeLoading = false;
        _isZodiacLoading = false;
        _isEducationLevelLoading = false;
        _isFamilyPlanLoading = false;
        _isCommunicationStyleLoading = false;
        _isPetOwnershipLoading = false;
        _isDrinkingHabitLoading = false;
        _isSmokingHabitLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data')),
      );
    }
  }
  Future<void> _updateUserInfo() async {
    setState(() {
      _isLoading = true;
    });

    final updatedData = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'bio': _bioController.text,
      'gender_id': _selectedGender?.id,
      'relationship_type_id': _selectedRelationshipType?.id,
      'zodiac_id': _selectedZodiac?.id,
      'education_level_id': _selectedEducationLevel?.id,
      'family_plan_id': _selectedFamilyPlan?.id,
      'communication_style_id': _selectedCommunicationStyle?.id,
      'pet_ownership_id': _selectedPetOwnership?.id,
      'drinking_habit_id': _selectedDrinkingHabit?.id,
      'smoking_habit_id': _selectedSmokingHabit?.id,
    };

    print('Sending update request to http://lovigo.net/api/v1/users/1 with data: ${jsonEncode(updatedData)}');

    try {
      final success = await authService.updateUserInfo(widget.accessToken, updatedData);

      if (success) {
        setState(() {
          userInfo = updatedData;

          _firstNameController.text = userInfo['first_name'] ?? '';
          _lastNameController.text = userInfo['last_name'] ?? '';
          _emailController.text = userInfo['email'] ?? '';
          _phoneController.text = userInfo['phone'] ?? '';
          _bioController.text = userInfo['bio'] ?? '';

          _selectedGender = userInfo['gender_id'] != null ? Gender(
            id: userInfo['gender_id'],
            name: '', // Assign name if necessary
          ) : null;

          _selectedRelationshipType = userInfo['relationship_type_id'] != null ? RelationshipType(
            id: userInfo['relationship_type_id'],
            name: '', // Assign name if necessary
          ) : null;

          _selectedZodiac = userInfo['zodiac_id'] != null ? Zodiac(
            id: userInfo['zodiac_id'],
            name: '', // Assign name if necessary
          ) : null;

          _selectedEducationLevel = userInfo['education_level_id'] != null ? EducationLevel(
            id: userInfo['education_level_id'],
            name: '', // Assign name if necessary
          ) : null;

          _selectedFamilyPlan = userInfo['family_plan_id'] != null ? FamilyPlan(
            id: userInfo['family_plan_id'],
            name: '', // Assign name if necessary
          ) : null;

          _selectedCommunicationStyle = userInfo['communication_style_id'] != null ? CommunicationStyle(
            id: userInfo['communication_style_id'],
            name: '', // Assign name if necessary
          ) : null;

          _selectedPetOwnership = userInfo['pet_ownership_id'] != null ? PetOwnership(
            id: userInfo['pet_ownership_id'],
            name: '', // Assign name if necessary
          ) : null;

          _selectedDrinkingHabit = userInfo['drinking_habit_id'] != null ? DrinkingHabits(
            id: userInfo['drinking_habit_id'],
            name: '', // Assign name if necessary
          ) : null;

          _selectedSmokingHabit = userInfo['smoking_habit_id'] != null ? SmokingHabit(
            id: userInfo['smoking_habit_id'],
            name: '', // Assign name if necessary
          ) : null;

          _genderController.text = _selectedGender?.name ?? '';
          _relationshipTypeController.text = _selectedRelationshipType?.name ?? '';
          _zodiacController.text = _selectedZodiac?.name ?? '';
          _educationLevelController.text = _selectedEducationLevel?.name ?? '';
          _familyPlanController.text = _selectedFamilyPlan?.name ?? '';
          _communicationStyleController.text = _selectedCommunicationStyle?.name ?? '';
          _petOwnershipController.text = _selectedPetOwnership?.name ?? '';
          _drinkingHabitController.text = _selectedDrinkingHabit?.name ?? '';
          _smokingHabitController.text = _selectedSmokingHabit?.name ?? '';
        });

        print('Update successful with data: ${jsonEncode(userInfo)}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Initial update failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                  buildSelectableExpansionTile<CommunicationStyle>(
                    label: 'Communication Style',
                    controller: _communicationStyleController,
                    isLoading: _isCommunicationStyleLoading,
                    items: _communicationStyles,
                    selectedItem: _selectedCommunicationStyle,
                    getItemName: (communicationStyle) => communicationStyle.name,
                    onSelect: (communicationStyle) {
                      setState(() {
                        _selectedCommunicationStyle = communicationStyle;
                        _communicationStyleController.text = communicationStyle.name;
                      });
                    },
                  ),
                  buildSelectableExpansionTile<PetOwnership>(
                    label: 'Pet Ownership',
                    controller: _petOwnershipController,
                    isLoading: _isPetOwnershipLoading,
                    items: _petOwnerships,
                    selectedItem: _selectedPetOwnership,
                    getItemName: (petOwnership) => petOwnership.name,
                    onSelect: (petOwnership) {
                      setState(() {
                        _selectedPetOwnership = petOwnership;
                        _petOwnershipController.text = petOwnership.name;
                      });
                    },
                  ),
                  buildSelectableExpansionTile<DrinkingHabits>(
                    label: 'Drinking Habit',
                    controller: _drinkingHabitController,
                    isLoading: _isDrinkingHabitLoading,
                    items: _drinkingHabits,
                    selectedItem: _selectedDrinkingHabit,
                    getItemName: (drinkingHabit) => drinkingHabit.name,
                    onSelect: (drinkingHabit) {
                      setState(() {
                        _selectedDrinkingHabit = drinkingHabit;
                        _drinkingHabitController.text = drinkingHabit.name;
                      });
                    },
                  ),
                  buildSelectableExpansionTile<SmokingHabit>(
                    label: 'Smoking Habit',
                    controller: _smokingHabitController,
                    isLoading: _isSmokingHabitLoading,
                    items: _smokingHabits,
                    selectedItem: _selectedSmokingHabit,
                    getItemName: (smokingHabit) => smokingHabit.name,
                    onSelect: (smokingHabit) {
                      setState(() {
                        _selectedSmokingHabit = smokingHabit;
                        _smokingHabitController.text = smokingHabit.name;
                      });
                    },
                  ),
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
    T? selectedItem,
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
                selectedTileColor: Colors.grey[300],
                selectedColor: Colors.black,
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
