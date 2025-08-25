import 'package:flutter/material.dart';
import 'package:mobilebuild/screens/signin_screen.dart';
import 'package:mobilebuild/screens/signup_screen.dart';
import 'package:mobilebuild/widgets/custom_scaffold.dart';
import 'package:mobilebuild/widgets/welcome_button.dart';

/// Displays a welcoming message and navigation options for signing up or signing in.
class WelcomeScreen extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;
  const WelcomeScreen({super.key, required this.themeModeNotifier});

 @override
Widget build(BuildContext context) {
  return CustomScaffold(
    child: SingleChildScrollView( 
      child: Column(
        children: [
          Flexible(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40.0,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'FLASHBUDGET\n',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 255, 204, 75),
                        ),
                      ),
                      TextSpan(
                        text: '\nWelcome!',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '\nBudget Your Finances in a Flash!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 300),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: WelcomeButton(
              buttonText: 'Sign Up',
              onTap: SignupScreen(themeModeNotifier: themeModeNotifier,),
              color: Color.fromARGB(255, 255, 193, 7),
              textColor: Colors.black,
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: WelcomeButton(
              buttonText: 'Sign In',
              onTap: SigninScreen(themeModeNotifier: themeModeNotifier,),
              color: Color.fromARGB(255, 255, 193, 7),
              textColor: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    ),
  );
}
}