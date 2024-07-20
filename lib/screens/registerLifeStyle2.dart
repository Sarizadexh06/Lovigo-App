// lib/screens/registerLifeStyle2.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import 'package:lovigoapp/screens/registerZodiac.dart';
import '../styles.dart';

class RegisterLifeStyle2 extends StatefulWidget {
  const RegisterLifeStyle2({super.key});

  @override
  State<RegisterLifeStyle2> createState() => _RegisterLifeStyleState();
}

class _RegisterLifeStyleState extends State<RegisterLifeStyle2> {
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
              child: buildWorkoutCards(context),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(25),
              child: buildPetCards(context),
            ),
            Divider(),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterZodiac()));
              },
              style: AppStyles.proceedButtonStyle,
              child: Text('Proceed',style: AppStyles.textStyleForButton,),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildWorkoutCards(BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: CustomWorkoutCard(),
  );
}

class CustomWorkoutCard extends StatelessWidget {
  const CustomWorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> workoutList = [
      "Everyday",
      "Often",
      "Never",
      "Sometimes",
    ];

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
            workoutList.length,
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
                        workoutList[index],
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

Widget buildPetCards(BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: CustomPetCard(),
  );
}

class CustomPetCard extends StatelessWidget {
  const CustomPetCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> petList = [
      "Dog",
      "Cat",
      "Hamster",
      "Bird",
      "Fish",
      "Reptile",
      "Don\'t have but love",
      "Pet-free"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children:[
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
            petList.length,
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
                        petList[index],
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
