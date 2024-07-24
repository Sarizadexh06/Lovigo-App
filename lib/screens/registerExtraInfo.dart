import 'package:flutter/material.dart';
import 'package:lovigoapp/modules/userInfo.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import 'package:lovigoapp/screens/registerLifeStyle2.dart';
import 'package:provider/provider.dart';
import '../styles.dart';

class RegisterExtraInfo extends StatefulWidget {
  const RegisterExtraInfo({Key? key}) : super(key: key);

  @override
  State<RegisterExtraInfo> createState() => _RegisterExtraInfoState();
}

class _RegisterExtraInfoState extends State<RegisterExtraInfo> {
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
                    'Let\'s talk about your information',
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: buildingSocialMediaCards(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: buildDrinkingCards(context),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterLifeStyle2(userInfo: UserInfo(),)),
                      );  */
                    },
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

Widget buildingSocialMediaCards(BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: const CustomSmokingCard(),
  );
}

class CustomSmokingCard extends StatelessWidget {
  const CustomSmokingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> socialMediaUse = [
      "Frequent",
      "Occasional",
      "Moderate ",
      "Rare",
      "None",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.facebook_rounded, color: Colors.white),
              const SizedBox(width: 15),
              Text(
                'How often do you use \n Social media?',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            socialMediaUse.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectSocialMediaUse(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedSocialMediaUseIndex != null && provider.selectedSocialMediaUseIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        socialMediaUse[index],
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
    child: const CustomDrinkingCard(),
  );
}

class CustomDrinkingCard extends StatelessWidget {
  const CustomDrinkingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> drinkingList = [
      "Sober",
      "Sober curious",
      "On special occasions",
      "Most Nights",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.local_drink_rounded, color: Colors.white),
              const SizedBox(width: 15),
              Text(
                "How often do you drink?",
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
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
                      padding: const EdgeInsets.all(13),
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
