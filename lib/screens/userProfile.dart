import 'dart:ui'; // `BackdropFilter` için gerekli
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovigoapp/styles.dart';
import 'package:lovigoapp/cardWidgetForEdit.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmi
          Positioned.fill(
            child:Image.asset("images/lovigoApp-logo.png", fit: BoxFit.contain,),
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.purpleAccent.withOpacity(0.3),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Username', style: AppStyles.textStyleTitle),
                const SizedBox(height: 20),
                ...List.generate(
                  5,
                      (index) => CardWidgetForEdit(key: UniqueKey()),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(hintText: 'Bio'),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  style: AppStyles.proceedButtonStyle,
                  onPressed: () {},
                  child: Text('Verify'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
