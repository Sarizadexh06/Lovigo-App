import 'package:flutter/material.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import 'package:lovigoapp/screens/login.dart';
import 'package:lovigoapp/screens/welcome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HabitProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lovigo App',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  WelcomePage(),
      ),
    );
  }
}
