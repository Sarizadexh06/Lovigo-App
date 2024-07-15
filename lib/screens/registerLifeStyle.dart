import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovigoapp/screens/registerInterests.dart';
import 'package:lovigoapp/screens/registerLifeStyle2.dart';
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
              child: buildSmokingCards(),
            ),
            Divider(),
            Divider(),

            Padding(
              padding: EdgeInsets.all(25),
              child: buildDrinkingCards(),
            ),
            Divider(),
        SizedBox(height: 30,),
          ElevatedButton(
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterLifeStyle2()));
              },
              style: AppStyles.elevatedButtonStyle,
          child: Text('Proceed'),)

          ],
        ),
      ),
    );
  }
}

Widget buildSmokingCards() {
  return Container(
    color: Colors.transparent,
    child: CustomCard(),
  );
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
              ),
          ]
          ),
        ),
        Wrap(
          spacing: 8.0, // Kartlar arasındaki yatay boşluk
          runSpacing: 4.0, // Satırlar arasındaki dikey boşluk
          children: List.generate(
            smokingList.length,
                (index) => InkWell(
              onTap: () {

              },
              child: Card(
                elevation: 4,
                shadowColor: Colors.cyanAccent,
                child: Padding(
                  padding: EdgeInsets.all(13),
                  child: Text(smokingList[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


Widget buildDrinkingCards() {
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
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

              },
              child: Card(
                elevation: 4,
                shadowColor: Colors.cyanAccent,
                child: Padding(
                  padding: EdgeInsets.all(13),
                  child: Text(drinkingList[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
