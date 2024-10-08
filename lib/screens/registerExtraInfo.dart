import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lovigoapp/modules/userInfo.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import 'package:lovigoapp/screens/registerHealth.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
import 'package:lovigoapp/modules/social_media_use.dart';
import 'package:lovigoapp/modules/education_level.dart';

class RegisterExtraInfo extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterExtraInfo({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<RegisterExtraInfo> createState() => _RegisterExtraInfoState();
}

class _RegisterExtraInfoState extends State<RegisterExtraInfo> {
  List<SocialMediaUse> socialMediaUsages = [];
  List<EducationLevel> educationLevels = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSocialMediaUsages();
    _fetchEducationLevels();
  }

  Future<void> _fetchEducationLevels() async {
    final response = await http.get(Uri.parse('http://lovigo.net/education-levels'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        educationLevels = jsonResponse.map((item) => EducationLevel.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load education levels');
    }
  }

  Future<void> _fetchSocialMediaUsages() async {
    final response = await http.get(Uri.parse('http://lovigo.net/social-media-usages'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        socialMediaUsages = jsonResponse.map((item) => SocialMediaUse.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load social media usages');
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
                  padding: const EdgeInsets.all(35),
                  child: Text(
                    'Let\'s talk about your information',
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
                      buildingSocialMediaCards(context, socialMediaUsages),
                      const SizedBox(height: 25),
                      buildingEducationCards(context, educationLevels),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterHealth(userInfo: widget.userInfo),
                        ),
                      );
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

Widget buildingSocialMediaCards(BuildContext context, List<SocialMediaUse> socialMediaUsages) {
  return Container(
    color: Colors.transparent,
    child: CustomSocialMediaCard(socialMediaUsages: socialMediaUsages),
  );
}

class CustomSocialMediaCard extends StatelessWidget {
  final List<SocialMediaUse> socialMediaUsages;

  const CustomSocialMediaCard({Key? key, required this.socialMediaUsages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            socialMediaUsages.length,
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
                        socialMediaUsages[index].name,
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



Widget buildingEducationCards(BuildContext context, List<EducationLevel> educationLevels) {
  return Container(
    color: Colors.transparent,
    child: CustomEducationCard(educationLevels: educationLevels),
  );
}

class CustomEducationCard extends StatelessWidget {
  final List<EducationLevel> educationLevels;

  const CustomEducationCard({Key? key, required this.educationLevels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.school_rounded, color: Colors.white),
              const SizedBox(width: 15),
              Text(
                'What is your \n education level?',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            educationLevels.length,
                (index) => InkWell(
              onTap: () {
                Provider.of<HabitProvider>(context, listen: false).selectEducationIndex(index);
              },
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedEducationIndex != null && provider.selectedEducationIndex == index;
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.cyanAccent,
                    color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        educationLevels[index].name,
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
