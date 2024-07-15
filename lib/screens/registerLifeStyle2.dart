import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovigoapp/screens/registerInterests.dart';
import '../styles.dart';
import 'package:google_fonts/google_fonts.dart';

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
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Let\'s talk about Life Style',
                style: AppStyles.registerPageTitleStyle,
              ),
            ),
            Divider(),

            Padding(
              padding: EdgeInsets.all(25),
              child: buildWorkoutCards(),
            ),

            Divider(),

            Padding(
              padding: EdgeInsets.all(25),
              child: buildPetCards(),
            ),
            Divider(),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (){

              },
              style: AppStyles.elevatedButtonStyle,
              child: Text('Proceed'),)

          ],
        ),
      ),
    );
  }
}

Widget buildWorkoutCards() {
  return Container(
    color: Colors.transparent,
    child: CustomCard(),
  );
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

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
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ]
          ),
        ),
        Wrap(
          spacing: 8.0, // Kartlar arasındaki yatay boşluk
          runSpacing: 4.0, // Satırlar arasındaki dikey boşluk
          children: List.generate(
            workoutList.length,
                (index) => InkWell(
              onTap: () {

              },
              child: Card(
                elevation: 4,
                shadowColor: Colors.cyanAccent,
                child: Padding(
                  padding: EdgeInsets.all(13),
                  child: Text(workoutList[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


Widget buildPetCards() {
  return Container(
    color: Colors.transparent,
    child: CustomDrinkingCard(),
  );
}

class CustomDrinkingCard extends StatelessWidget {
  const CustomDrinkingCard({super.key});

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
                  "Do you have  any pets?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ]
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            petList.length,
                (index) => InkWell(
              onTap: () {

              },
              child: Card(
                elevation: 4,
                shadowColor: Colors.cyanAccent,
                child: Padding(
                  padding: EdgeInsets.all(13),
                  child: Text(petList[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
