import 'package:lovigoapp/screens/registerDistance.dart';

import 'registerInfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovigoapp/screens/registerInfo.dart';
import '../styles.dart';

void main() {
  runApp(LovigoApp());
}

class LovigoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterInterests(),
    );
  }
}

class RegisterInterests extends StatefulWidget {
  final VoidCallback? onProceed;

  const RegisterInterests({super.key, this.onProceed});

  @override
  State<RegisterInterests> createState() => _RegisterInterestsState();
}

class _RegisterInterestsState extends State<RegisterInterests> {
  final List<Map<String, String>> imagePaths = [
    {'imagePath': 'images/love1.png', 'label': 'Love'},
    {'imagePath': 'images/result.png', 'label': 'Relationship'},
    {'imagePath': 'images/ring.png', 'label': 'Marriage'},
    {'imagePath': 'images/friend.png', 'label': 'Friendship'}
  ];

  String? _selectedLabel;

  void _onCardClick(String label) {
    setState(() {
      if (_selectedLabel == label) {
        _selectedLabel = null;
      } else {
        _selectedLabel = label;
      }
    });
  }

  void _onProceed() {
    if (_selectedLabel != null && widget.onProceed != null) {
      widget.onProceed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gradientDecoration,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40,left: 30),
                  child: Text(
                    'Select your own wish!',
                    style: AppStyles.textStyleTitle,
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      return InterestCard(
                        imagePath: imagePaths[index]['imagePath']!,
                        label: imagePaths[index]['label']!,
                        isSelected:
                        _selectedLabel == imagePaths[index]['label'],
                        isClickable: _selectedLabel == null ||
                            _selectedLabel == imagePaths[index]['label'],
                        onCardClick: _onCardClick,
                      );
                    },
                  ),
                ),
                if (_selectedLabel != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                      width: 180,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterDistance(),
                                ));
                          });
                        },
                        child: Text(
                          'Proceed',
                          style: AppStyles.textStyleForButton,
                        ),
                        style: AppStyles.proceedButtonStyle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InterestCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected;
  final bool isClickable;
  final Function(String) onCardClick;

  InterestCard({
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.isClickable,
    required this.onCardClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isClickable ? () => onCardClick(label) : null,
      child: Card(
        color: isSelected
            ? Color.fromARGB(255, 231, 103, 236)
            : Color.fromARGB(255, 255, 240, 245),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 189, 35, 186).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
