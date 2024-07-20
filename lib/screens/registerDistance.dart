import 'package:flutter/cupertino.dart';
import 'package:lovigoapp/screens/registerLifeStyle.dart';

import 'registerInfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovigoapp/screens/registerInfo.dart';
import '../styles.dart';


class RegisterDistance extends StatefulWidget {
  const RegisterDistance({super.key});

  @override
  State<RegisterDistance> createState() => _RegisterDistanceState();
}

class _RegisterDistanceState extends State<RegisterDistance> {
  double _currentSliderValue=0;
  void _proceedAnotherPage() {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterLifeStyle()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gradientDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: EdgeInsets.only(top: 60,right: 1),
              child: Text('Your distance \n preference?',style: AppStyles.textStyleTitle,),),

            Padding(
                padding: EdgeInsets.all(25),
                child: Text('Use the slider to set maximum distance you want your potential matches to be located.',style: TextStyle(color: Colors.white),)),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Distance',
                    style: TextStyle( color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_currentSliderValue.round()} km', // Slider değeri sağ üst köşede km olarak gösteriliyor
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Slider(
                value: _currentSliderValue,
                min: 0,
                max: 100,
                divisions: 5,
                activeColor:Colors.purpleAccent,
                inactiveColor: Colors.white,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },

              ),
            ),

            SizedBox(height: 100,),

            ElevatedButton(
              onPressed: _proceedAnotherPage,
              style:AppStyles.proceedButtonStyle,
              child: Text('Proceed',style: AppStyles.textStyleForButton,),
            )
          ],
        ),
      ),
    );
  }
}
