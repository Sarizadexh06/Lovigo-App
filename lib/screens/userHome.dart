import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:lovigoapp/styles.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<CardWidget> cardWidgets = [
    CardWidget('https://qph.cf2.quoracdn.net/main-qimg-f70328c6802355422a6b246acc81692e', 'Beyza'),
    CardWidget('https://i.pinimg.com/564x/05/42/d3/0542d32aef042883639ac61d520336c7.jpg', 'Sevda'),
    CardWidget('https://i.pinimg.com/736x/3f/11/5a/3f115a896efe622fdd1f08e8334f3247.jpg', 'Büşra'),
    CardWidget('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBdcEsMWTwlB--bbctUeby9Kq7Enhlgc7grQ&s', 'Ece'),
    CardWidget('https://i.pinimg.com/736x/4e/79/5e/4e795e6eb982ffb302bcb841db8d4594.jpg', 'Tuğçe'),
  ];

  String swipeMessage = '';

  List<Widget> get demoCards {
    return cardWidgets.map((card) => card.buildCard()).toList();
  }

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
              padding: EdgeInsets.only(top: 30),
              child: Text('Lovigo', style: AppStyles.registerPageTitleStyle),
            ),
            if (swipeMessage.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  swipeMessage,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            Expanded(
              child: TCard(
                cards: demoCards,
                size: Size(MediaQuery.of(context).size.width * 0.9,
                    MediaQuery.of(context).size.height * 0.9),
                onForward: (index, info) {
                  setState(() {
                    if (info.direction == SwipDirection.Right) {
                      swipeMessage = 'Liked';
                    } else if (info.direction == SwipDirection.Left) {
                      swipeMessage = 'Disliked';
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}