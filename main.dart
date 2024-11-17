import 'package:flutter/material.dart';
import 'package:mobilebuild/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Budget',
      theme: ThemeData.light(),
      home: const WelcomeScreen()
    );
  }
}