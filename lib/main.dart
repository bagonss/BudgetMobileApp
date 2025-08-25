import 'package:flutter/material.dart';
import 'package:mobilebuild/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This controls the app’s current theme (light or dark)
  final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mobile Budget',
          theme: ThemeData.light(), // Light mode theme
          darkTheme: ThemeData.dark(), // Dark mode theme
          themeMode: themeMode, // Dynamically switch between themes
          home: WelcomeScreen(themeModeNotifier: themeModeNotifier),
        );
      },
    );
  }
}
