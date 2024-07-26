import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import 'package:lovigoapp/screens/registerLifeStyle2.dart';
import '../styles.dart';
import 'package:lovigoapp/modules/smoking_habit.dart';
import 'package:lovigoapp/modules/drinking_habit.dart';
import 'package:lovigoapp/modules/userInfo.dart';

class RegisterLifeStyle extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterLifeStyle({super.key, required this.userInfo});

  @override
  State<RegisterLifeStyle> createState() => _RegisterLifeStyleState();
}

class _RegisterLifeStyleState extends State<RegisterLifeStyle> {
  List<SmokingHabit> _smokingHabits = [];
  List<Datum> _drinkingHabits = [];
  bool _isLoadingSmoking = true;
  bool _isLoadingDrinking = true;

  @override
  void initState() {
    super.initState();
    _fetchSmokingHabits();
    _fetchDrinkingHabits();
  }

  Future<void> _fetchSmokingHabits() async {
    final response = await http.get(Uri.parse('http://lovigo.net/smoking-habits'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        _smokingHabits = jsonResponse.map((habit) => SmokingHabit.fromJson(habit)).toList();
        _isLoadingSmoking = false;
      });
    } else {
      throw Exception('Failed to load smoking habits');
    }
  }

  Future<void> _fetchDrinkingHabits() async {
    final response = await http.get(Uri.parse('http://lovigo.net/drinking-habits'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        _drinkingHabits = jsonResponse.map((habit) => Datum.fromJson(habit)).toList();
        _isLoadingDrinking = false;
      });
    } else {
      throw Exception('Failed to load drinking habits');
    }
  }

  void _onProceed() {
    final provider = Provider.of<HabitProvider>(context, listen: false);

    if (provider.selectedSmokingIndex != null && provider.selectedDrinkingIndex != null) {
      if (provider.selectedSmokingIndex! < _smokingHabits.length && provider.selectedDrinkingIndex! < _drinkingHabits.length) {
        final selectedSmokingHabitId = _smokingHabits[provider.selectedSmokingIndex!].id;
        final selectedDrinkingHabitId = _drinkingHabits[provider.selectedDrinkingIndex!].id;

        if (selectedSmokingHabitId != null && selectedDrinkingHabitId != null) {
          widget.userInfo.smokingHabitId = selectedSmokingHabitId;
          widget.userInfo.drinkingHabitId = selectedDrinkingHabitId;

          // Debug log to check values
          log('Selected Smoking Habit ID: $selectedSmokingHabitId');
          log('Selected Drinking Habit ID: $selectedDrinkingHabitId');
          log('User Info before navigation: ${widget.userInfo}');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterLifeStyle2(userInfo: widget.userInfo),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid selection')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid selection')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both smoking and drinking habits')),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(35),
                  child: Text(
                    'Let\'s talk about your life style',
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleTitle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: _isLoadingSmoking
                      ? Center(child: CircularProgressIndicator())
                      : buildSmokingCards(context, _smokingHabits),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: _isLoadingDrinking
                      ? Center(child: CircularProgressIndicator())
                      : buildDrinkingCards(context, _drinkingHabits),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: _onProceed,
                    style: AppStyles.proceedButtonStyle,
                    child: Text('Proceed', style: AppStyles.textStyleForButton),
                  ),
                )
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

Widget buildSmokingCards(BuildContext context, List<SmokingHabit> smokingHabits) {
  return Container(
    color: Colors.transparent,
    child: CustomSmokingCard(smokingHabits: smokingHabits),
  );
}

class CustomSmokingCard extends StatelessWidget {
  final List<SmokingHabit> smokingHabits;

  const CustomSmokingCard({super.key, required this.smokingHabits});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.smoking_rooms_rounded, color: Colors.white,),
              SizedBox(width: 15,),
              Text(
                "How often you smoke?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            smokingHabits.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectSmokingIndex(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedSmokingIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: Text(
                        smokingHabits[index].name,
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

Widget buildDrinkingCards(BuildContext context, List<Datum> drinkingHabits) {
  return Container(
    color: Colors.transparent,
    child: CustomDrinkingCard(drinkingHabits: drinkingHabits),
  );
}

class CustomDrinkingCard extends StatelessWidget {
  final List<Datum> drinkingHabits;

  const CustomDrinkingCard({super.key, required this.drinkingHabits});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.local_drink_rounded, color: Colors.white,),
              SizedBox(width: 15,),
              Text(
                "How often you drink?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            drinkingHabits.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectDrinkingIndex(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedDrinkingIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: Text(
                        drinkingHabits[index].name ?? '',
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
