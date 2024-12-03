import 'package:flutter/material.dart';

/// A customizable button widget used for navigation with a modern rounded design.
/// It triggers navigation to a specified screen when tapped.
class WelcomeButton extends StatelessWidget {
  // Constructor to initialize button properties
  const WelcomeButton({
    super.key,
    this.buttonText, // The text displayed on the button
    this.onTap, // The screen to navigate to when the button is tapped
    this.color, // The background color of the button
    required Color textColor, // Required parameter for text color (not used in the code)
  });

  final String? buttonText; // Button label
  final Widget? onTap; // Navigation target widget
  final Color? color; // Button background color

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Defines the behavior when the button is tapped
      onTap: () {
        if (onTap != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (e) => onTap!, // Navigates to the specified widget
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(30.0), // Internal spacing around the text
        decoration: BoxDecoration(
          color: color ?? Colors.grey, // Sets button background color (defaults to grey if null)
          borderRadius: const BorderRadius.all(
            Radius.circular(50), // Rounded edges for a modern look
          ),
        ),
        child: Text(
          buttonText ?? 'Button', // Displays the button text or defaults to "Button"
          textAlign: TextAlign.center, // Centers the text inside the button
          style: const TextStyle(
            fontSize: 20.0, // Font size for the button text
            fontWeight: FontWeight.bold, // Bold text style
          ),
        ),
      ),
    );
  }
}
