import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lovigoapp/modules/userInfo.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
import 'package:lovigoapp/modules/family_plan.dart';
import 'package:lovigoapp/modules/communication_style.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import 'package:lovigoapp/services/api_service.dart';

class RegisterFamilyPlans extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterFamilyPlans({Key? key, required this.userInfo}) : super(key: key);

  @override
  _RegisterFamilyPlansState createState() => _RegisterFamilyPlansState();
}

class _RegisterFamilyPlansState extends State<RegisterFamilyPlans> {
  List<FamilyPlan> familyPlans = [];
  List<CommunicationStyle> communicationStyles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFamilyPlans();
    _fetchCommunicationStyles();
  }

  Future<void> _fetchFamilyPlans() async {
    final response = await http.get(Uri.parse('http://lovigo.net/family-plans'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        familyPlans = jsonResponse.map((item) => FamilyPlan.fromJson(item)).toList();
        _checkLoadingStatus();
      });
    } else {
      throw Exception('Failed to load family plans');
    }
  }

  Future<void> _fetchCommunicationStyles() async {
    final response = await http.get(Uri.parse('http://lovigo.net/communication-styles'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        communicationStyles = jsonResponse.map((item) => CommunicationStyle.fromJson(item)).toList();
        _checkLoadingStatus();
      });
    } else {
      throw Exception('Failed to load communication styles');
    }
  }

  void _checkLoadingStatus() {
    if (familyPlans.isNotEmpty && communicationStyles.isNotEmpty) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitUserInfo() async {
    final provider = Provider.of<HabitProvider>(context, listen: false);

    // userInfo nesnesini logla
    debugPrint('UserInfo: ${widget.userInfo.firstName}, ${widget.userInfo.lastName}, ${widget.userInfo.email}, ${widget.userInfo.phone}, ${widget.userInfo.password}, ${widget.userInfo.genderId}, ${widget.userInfo.relationshipTypeId}, ${widget.userInfo.smokingHabitId}, ${widget.userInfo.drinkingHabitId}, ${widget.userInfo.workoutHabitId}, ${widget.userInfo.petOwnershipId}');
    debugPrint('Selected Values: zodiacId: ${provider.selectedZodiacIndex}, socialMediaUseId: ${provider.selectedSocialMediaUseIndex}, educationId: ${provider.selectedEducationIndex}, dietaryPreferenceId: ${provider.selectedDietaryPreferenceIndex}, sleepingRoutineId: ${provider.selectedSleepingRoutineIndex}, familyPlanId: ${provider.selectedFamilyPlanIndex}, communicationStyleId: ${provider.selectedCommunicationStyleIndex}');

    // Değerleri ayrı ayrı logla
    if (widget.userInfo.workoutHabitId == null) {
      debugPrint('workoutHabitId is null');
    } else {
      debugPrint('workoutHabitId: ${widget.userInfo.workoutHabitId}');
    }

    if (provider.selectedSocialMediaUseIndex == null) {
      debugPrint('socialMediaUseId is null');
    } else {
      debugPrint('socialMediaUseId: ${provider.selectedSocialMediaUseIndex}');
    }

    if (provider.selectedEducationIndex == null) {
      debugPrint('educationId is null');
    } else {
      debugPrint('educationId: ${provider.selectedEducationIndex}');
    }

    if (provider.selectedDietaryPreferenceIndex == null) {
      debugPrint('dietaryPreferenceId is null');
    } else {
      debugPrint('dietaryPreferenceId: ${provider.selectedDietaryPreferenceIndex}');
    }

    // Nullable değerleri kontrol et
    if (widget.userInfo.genderId == null ||
        widget.userInfo.relationshipTypeId == null ||
        widget.userInfo.smokingHabitId == null ||
        widget.userInfo.drinkingHabitId == null ||
        widget.userInfo.workoutHabitId == null ||
        widget.userInfo.petOwnershipId == null ||
        provider.selectedZodiacIndex == null ||
        provider.selectedSocialMediaUseIndex == null ||
        provider.selectedEducationIndex == null ||
        provider.selectedDietaryPreferenceIndex == null ||
        provider.selectedSleepingRoutineIndex == null ||
        provider.selectedFamilyPlanIndex == null ||
        provider.selectedCommunicationStyleIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all the required fields.'),
      ));
      return;
    }

    try {
      final apiService = ApiService();
      final userId = await apiService.createUser(
        firstName: widget.userInfo.firstName,
        lastName: widget.userInfo.lastName,
        email: widget.userInfo.email,
        phone: widget.userInfo.phone,
        password: widget.userInfo.password,
        genderId: widget.userInfo.genderId,
        relationshipTypeId: widget.userInfo.relationshipTypeId,
        smokingHabitId: widget.userInfo.smokingHabitId,
        drinkingHabitId: widget.userInfo.drinkingHabitId,
        workoutHabitId: widget.userInfo.workoutHabitId,
        petOwnershipId: widget.userInfo.petOwnershipId,
        zodiacId: provider.selectedZodiacIndex! + 1,
        socialMediaUseId: provider.selectedSocialMediaUseIndex!+1,
        educationId: provider.selectedEducationIndex! + 1,
        dietaryPreferenceId: provider.selectedDietaryPreferenceIndex!+1,
        sleepingRoutineId: provider.selectedSleepingRoutineIndex!+1,
        familyPlanId: provider.selectedFamilyPlanIndex! + 1,
        communicationStyleId: provider.selectedCommunicationStyleIndex! + 1,
      );

      // User created successfully, navigate to another page or show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User created successfully with ID: $userId')));
    } catch (e) {
      // Detailed error logging
      debugPrint('Exception caught: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create user: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: gradientDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35),
                    child: Text(
                      'Let\'s talk about your family plans',
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleTitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Column(
                      children: [
                        buildingFamilyPlanCards(context, familyPlans),
                        const SizedBox(height: 25),
                        buildingCommunicationStyleCards(context, communicationStyles),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: ElevatedButton(
                      onPressed: _submitUserInfo, // API'ye verileri gönder
                      style: AppStyles.proceedButtonStyle,
                      child: Text('Proceed', style: AppStyles.textStyleForButton),
                    ),
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
                padding: const EdgeInsets.all(10),
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

Widget buildingFamilyPlanCards(BuildContext context, List<FamilyPlan> familyPlans) {
  return Container(
    color: Colors.transparent,
    child: CustomFamilyPlanCard(familyPlans: familyPlans),
  );
}

class CustomFamilyPlanCard extends StatelessWidget {
  final List<FamilyPlan> familyPlans;

  const CustomFamilyPlanCard({Key? key, required this.familyPlans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.family_restroom_rounded, color: Colors.white),
              const SizedBox(width: 15),
              Text(
                'What are your \n family plans?',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            familyPlans.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectFamilyPlanIndex(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedFamilyPlanIndex != null && provider.selectedFamilyPlanIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        familyPlans[index].name,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildingCommunicationStyleCards(BuildContext context, List<CommunicationStyle> communicationStyles) {
  return Container(
    color: Colors.transparent,
    child: CustomCommunicationStyleCard(communicationStyles: communicationStyles),
  );
}

class CustomCommunicationStyleCard extends StatelessWidget {
  final List<CommunicationStyle> communicationStyles;

  const CustomCommunicationStyleCard({Key? key, required this.communicationStyles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.phone_rounded, color: Colors.white),
              const SizedBox(width: 15),
              Text(
                'What is your \n communication style?',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            communicationStyles.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectCommunicationStyleIndex(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedCommunicationStyleIndex != null && provider.selectedCommunicationStyleIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        communicationStyles[index].name,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}