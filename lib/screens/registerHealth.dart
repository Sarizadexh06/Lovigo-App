import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lovigoapp/modules/userInfo.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
import 'package:lovigoapp/modules/dietary_preference.dart';
import 'package:lovigoapp/modules/sleeping_routine.dart';
import 'package:lovigoapp/screens/registerFamilyPlans.dart';

class RegisterHealth extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterHealth({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<RegisterHealth> createState() => _RegisterHealthState();
}

class _RegisterHealthState extends State<RegisterHealth> {
  List<DietaryPreference> dietaryPreferences = [];
  List<SleepingRoutine> sleepingRoutines = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDietaryPreferences();
    _fetchSleepingRoutines();
  }

  Future<void> _fetchDietaryPreferences() async {
    final response = await http.get(Uri.parse('http://lovigo.net/dietary-preferances'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        dietaryPreferences = jsonResponse.map((item) => DietaryPreference.fromJson(item)).toList();
        _checkLoadingStatus();
      });
    } else {
      throw Exception('Failed to load dietary preferences');
    }
  }

  Future<void> _fetchSleepingRoutines() async {
    final response = await http.get(Uri.parse('http://lovigo.net/sleeping-routines'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        sleepingRoutines = jsonResponse.map((item) => SleepingRoutine.fromJson(item)).toList();
        _checkLoadingStatus();
      });
    } else {
      throw Exception('Failed to load sleeping routines');
    }
  }

  void _checkLoadingStatus() {
    if (dietaryPreferences.isNotEmpty && sleepingRoutines.isNotEmpty) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onProceed() {
    final provider = Provider.of<HabitProvider>(context, listen: false);


    widget.userInfo.dietaryPreferenceId = (provider.selectedDietaryPreferenceIndex != null
        ? dietaryPreferences[provider.selectedDietaryPreferenceIndex!].id
        : null)!;
    widget.userInfo.sleepingRoutineId = (provider.selectedSleepingRoutineIndex != null
        ? sleepingRoutines[provider.selectedSleepingRoutineIndex!].id
        : null)!;

    // Bilgilerin doğru şekilde eklendiğini kontrol etmek için log ekleyelim
    print('UserInfo dietaryPreferenceId: ${widget.userInfo.dietaryPreferenceId}');
    print('UserInfo sleepingRoutineId: ${widget.userInfo.sleepingRoutineId}');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterFamilyPlans(userInfo: widget.userInfo),
      ),
    );
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: Text(
                    'Let\'s talk about your health',
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Column(
                    children: [
                      buildingDietaryPreferenceCards(context, dietaryPreferences),
                      const SizedBox(height: 25),
                      buildingSleepingRoutineCards(context, sleepingRoutines),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: _onProceed, // Butonun onPressed fonksiyonunu güncelledim
                    style: AppStyles.proceedButtonStyle,
                    child: Text('Proceed', style: AppStyles.textStyleForButton),
                  ),
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

Widget buildingDietaryPreferenceCards(BuildContext context, List<DietaryPreference> dietaryPreferences) {
  return Container(
    color: Colors.transparent,
    child: CustomDietaryPreferenceCard(dietaryPreferences: dietaryPreferences),
  );
}

class CustomDietaryPreferenceCard extends StatelessWidget {
  final List<DietaryPreference> dietaryPreferences;

  const CustomDietaryPreferenceCard({Key? key, required this.dietaryPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.fastfood_rounded, color: Colors.white),
              const SizedBox(width: 15),
              Text(
                'What is your \n dietary preference?',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            dietaryPreferences.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectDietaryPreferenceIndex(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedDietaryPreferenceIndex != null && provider.selectedDietaryPreferenceIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        dietaryPreferences[index].name,
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

Widget buildingSleepingRoutineCards(BuildContext context, List<SleepingRoutine> sleepingRoutines) {
  return Container(
    color: Colors.transparent,
    child: CustomSleepingRoutineCard(sleepingRoutines: sleepingRoutines),
  );
}

class CustomSleepingRoutineCard extends StatelessWidget {
  final List<SleepingRoutine> sleepingRoutines;

  const CustomSleepingRoutineCard({Key? key, required this.sleepingRoutines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.nights_stay_rounded, color: Colors.white),
              const SizedBox(width: 15),
              Text(
                'What is your \n sleeping routine?',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            sleepingRoutines.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectSleepingRoutineIndex(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedSleepingRoutineIndex != null && provider.selectedSleepingRoutineIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        sleepingRoutines[index].name,
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
