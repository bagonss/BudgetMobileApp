import 'package:flutter/material.dart';
import 'package:mobilebuild/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

/// Initializes Firebase and runs the app.
void main() async {
  // Ensures widgets are bound and Firebase initialization is performed correctly
  WidgetsFlutterBinding.ensureInitialized();
  // Initializes Firebase for the app
  await Firebase.initializeApp();
  // Runs the app
  runApp(const MyApp());
}

/// Root widget of the application that defines app-wide settings.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'Mobile Budget', // Title of the app
      theme: ThemeData.light(), // Sets the light theme for the app
      home: const WelcomeScreen(), // Defines the initial screen of the app
    );
  }
}
