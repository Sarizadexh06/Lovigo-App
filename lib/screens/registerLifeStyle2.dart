import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import 'package:lovigoapp/screens/registerZodiac.dart';
import '../styles.dart';
import 'package:lovigoapp/modules/workout_habit.dart';
import 'package:lovigoapp/modules/userInfo.dart';

class RegisterLifeStyle2 extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterLifeStyle2({super.key, required this.userInfo});

  @override
  State<RegisterLifeStyle2> createState() => _RegisterLifeStyle2State();
}

class _RegisterLifeStyle2State extends State<RegisterLifeStyle2> {
  List<Datum> _workoutHabits = [];
  List<Datum> _petOwnerships = [];
  bool _isLoadingWorkout = true;
  bool _isLoadingPet = true;

  @override
  void initState() {
    super.initState();
    _fetchWorkoutHabits();
    _fetchPetOwnerships();
  }

  Future<void> _fetchWorkoutHabits() async {
    final response = await http.get(Uri.parse('http://lovigo.net/workout-routines'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _workoutHabits = WorkoutHabits.fromJson(jsonResponse).data;
        _isLoadingWorkout = false;
      });
    } else {
      throw Exception('Failed to load workout habits');
    }
  }

  Future<void> _fetchPetOwnerships() async {
    final response = await http.get(Uri.parse('http://lovigo.net/pet-ownerships'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _petOwnerships = WorkoutHabits.fromJson(jsonResponse).data; // Assuming same structure
        _isLoadingPet = false;
      });
    } else {
      throw Exception('Failed to load pet ownerships');
    }
  }

  void _onProceed() async {
    final provider = Provider.of<HabitProvider>(context, listen: false);

    if (provider.selectedWorkoutIndex != null && provider.selectedPetIndex != null) {
      if (provider.selectedWorkoutIndex! < _workoutHabits.length && provider.selectedPetIndex! < _petOwnerships.length) {
        final selectedWorkoutHabitId = _workoutHabits[provider.selectedWorkoutIndex!].id;
        final selectedPetOwnershipId = _petOwnerships[provider.selectedPetIndex!].id;

        if (selectedWorkoutHabitId != null && selectedPetOwnershipId != null) {
          widget.userInfo.workoutHabitId = selectedWorkoutHabitId;
          widget.userInfo.petOwnershipId = selectedPetOwnershipId;

          // Debug log to check values
          log('Selected Workout Habit ID: $selectedWorkoutHabitId');
          log('Selected Pet Ownership ID: $selectedPetOwnershipId');
          log('User Info before navigation: ${widget.userInfo}');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterZodiac(userInfo: widget.userInfo),
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
        SnackBar(content: Text('Please select both workout and pet ownership')),
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
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Let\'s talk about Life Style',
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleTitle,
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: _isLoadingWorkout
                      ? Center(child: CircularProgressIndicator())
                      : buildWorkoutCards(context, _workoutHabits),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: _isLoadingPet
                      ? Center(child: CircularProgressIndicator())
                      : buildPetCards(context, _petOwnerships),
                ),
                Divider(),
                SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: _onProceed,
                  style: AppStyles.proceedButtonStyle,
                  child: Text('Proceed', style: AppStyles.textStyleForButton),
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

Widget buildWorkoutCards(BuildContext context, List<Datum> workoutHabits) {
  return Container(
    color: Colors.transparent,
    child: CustomWorkoutCard(workoutHabits: workoutHabits),
  );
}

class CustomWorkoutCard extends StatelessWidget {
  final List<Datum> workoutHabits;

  const CustomWorkoutCard({super.key, required this.workoutHabits});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.fitness_center, color: Colors.white,),
              SizedBox(width: 15,),
              Text(
                "Do you workout?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            workoutHabits.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectWorkoutIndex(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedWorkoutIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: Text(
                        workoutHabits[index].name ?? '',
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


Widget buildPetCards(BuildContext context, List<Datum> petOwnerships) {
  return Container(
    color: Colors.transparent,
    child: CustomPetCard(petOwnerships: petOwnerships),
  );
}

class CustomPetCard extends StatelessWidget {
  final List<Datum> petOwnerships;

  const CustomPetCard({super.key, required this.petOwnerships});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.pets_rounded, color: Colors.white,),
              SizedBox(width: 15,),
              Text(
                "Do you have any pets?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            petOwnerships.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectPetIndex(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedPetIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: Text(
                        petOwnerships[index].name ?? '',
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
