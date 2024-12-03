import 'package:flutter/material.dart';
import 'package:mobilebuild/screens/signin_screen.dart';
import 'package:mobilebuild/screens/signup_screen.dart';
import 'package:mobilebuild/theme/theme.dart';
import 'package:mobilebuild/widgets/custom_scaffold.dart';
import 'package:mobilebuild/widgets/welcome_button.dart';

/// Displays a welcoming message and navigation options for signing up or signing in.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // CustomScaffold provides consistent styling for the app
      child: Column(
        children: [
          // Flexible container for the welcome text at the top
          Flexible(
            flex: 0, // Ensures the space used is minimal and content-driven
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
                      // App title
                      TextSpan(
                        text: 'FLASHBUDGET\n',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 255, 204, 75),
                        ),
                      ),
                      // Welcome text
                      TextSpan(
                        text: '\nWelcome!',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Tagline
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
          // Flexible container for the sign-up and sign-in buttons
          Flexible(
            flex: 5, // Allocates more space for the buttons
            child: Column(
              children: [
                // Spacer for positioning the buttons further down
                const SizedBox(height: 300),
                // Sign-Up button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: WelcomeButton(
                    buttonText: 'Sign Up', // Button text
                    onTap: const SignupScreen(), // Navigate to the SignupScreen
                    color: lightColorScheme.primary, // Button background color
                    textColor: Colors.black, // Button text color
                  ),
                ),
                const SizedBox(height: 50), // Spacer between buttons
                // Sign-In button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: WelcomeButton(
                    buttonText: 'Sign In', // Button text
                    onTap: const SigninScreen(), // Navigate to the SigninScreen
                    color: lightColorScheme.primary, // Button background color
                    textColor: Colors.black, // Button text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
