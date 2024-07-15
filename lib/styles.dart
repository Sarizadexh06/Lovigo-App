import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const EdgeInsets customPadding = EdgeInsets.only(top: 50, left: 20, right: 20);
const EdgeInsets loginPadding = EdgeInsets.only(top: 30, bottom: 5);

const TextStyle textStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w800,
    color: Color.fromARGB(255, 220, 159, 235));

const TextStyle textStyleForLoginButton =
TextStyle(fontSize: 22, fontWeight: FontWeight.w500);

final BoxDecoration gradientDecoration = const BoxDecoration(
  gradient: RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [
      Color.fromARGB(255, 237, 130, 247),
      Color.fromARGB(255, 242, 174, 174),
    ],
    stops: [0.3, 1.0], // İlk renk için %30, ikinci renk için %100 stop değeri
  ),
);

final textFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide.none,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  hintText: 'Enter your text',
  hintStyle: TextStyle(color: Colors.grey),
);


class AppStyles {
  static final TextStyle registerPageTitleStyle = GoogleFonts.greatVibes(
    fontSize: 55,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 249, 249, 249),
    shadows: [
      Shadow(
        blurRadius: 10,
        color: Color.fromARGB(255, 224, 112, 244).withOpacity(0.8),
        offset: Offset(0, 3),
      ),
      Shadow(
        blurRadius: 10,
        color: Colors.blueAccent.withOpacity(0.8),
        offset: Offset(0, 0),
      ),
    ],
  );

  static final EdgeInsetsGeometry registerPagePadding = EdgeInsets.only(
    bottom: 60,
    top: 120,
  );

  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    fixedSize: Size(300, 75),
    foregroundColor: Colors.purpleAccent,
    backgroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    textStyle: TextStyle(
      color: Colors.purple,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide.none,
    ),
    shadowColor: Colors.blueAccent.withOpacity(0.3),
    elevation: 10,


  );
  static final ButtonStyle proceedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Color.fromARGB(255, 184, 62, 225), backgroundColor: Colors.white,
    textStyle: GoogleFonts.greatVibes(
      fontSize: 35,
      fontWeight: FontWeight.bold,
    ),
    minimumSize: Size(180, 50),
    padding: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );


}