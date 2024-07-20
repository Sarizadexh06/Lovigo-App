// lib/screens/registerLifeStyle.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import 'package:lovigoapp/screens/registerInterests.dart';
import 'package:lovigoapp/screens/registerLifeStyle2.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterLifeStyle extends StatefulWidget {
  const RegisterLifeStyle({super.key});

  @override
  State<RegisterLifeStyle> createState() => _RegisterLifeStyleState();
}

class _RegisterLifeStyleState extends State<RegisterLifeStyle> {
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
              padding: EdgeInsets.all(35),
              child: Text(
                'Let\'s talk about your life style',
                textAlign: TextAlign.center,
                style: AppStyles.textStyleTitle,
              ),
            ),
         //  Divider(),
            Padding(
              padding: EdgeInsets.all(25),
              child: buildSmokingCards(context),
            ),

            //Divider(),
            Padding(
              padding: EdgeInsets.all(25),
              child: buildDrinkingCards(context),
            ),
            //Divider(),
            SizedBox(height: 30,),
            SizedBox(
              height: 50,
            width: 180,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterLifeStyle2()));
                },
                style: AppStyles.proceedButtonStyle,
                child: Text('Proceed', style: AppStyles.textStyleForButton),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildSmokingCards(BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: CustomSmokingCard(),
  );
}

class CustomSmokingCard extends StatelessWidget {
  const CustomSmokingCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> smokingList = [
      "Smoker",
      "Non-Smoker",
      "Occasional Smoker",
      "Former Smoker",
    ];

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
            smokingList.length,
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
                        smokingList[index],
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

Widget buildDrinkingCards(BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: CustomDrinkingCard(),
  );
}

class CustomDrinkingCard extends StatelessWidget {
  const CustomDrinkingCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> drinkingList = [
      "Sober",
      "Sober curious",
      "On special occasions",
      "Most Nights"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              children:[
                Icon(Icons.local_drink_rounded, color: Colors.white,),
                SizedBox(width: 15,),
                Text(
                  "How often you drink?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ]
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            drinkingList.length,
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
                        drinkingList[index],
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
