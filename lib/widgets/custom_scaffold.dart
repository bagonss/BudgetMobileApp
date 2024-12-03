import 'package:flutter/material.dart';

/// A reusable scaffold widget that applies a consistent background image,
/// app bar styling, and layout to all screens in the app.
class CustomScaffold extends StatelessWidget {
  // A child widget to be rendered within the scaffold
  const CustomScaffold({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar configuration
      appBar: AppBar(
        // Sets the icon theme for the app bar (e.g., back button color)
        iconTheme: const IconThemeData(color: Colors.white),
        // Makes the app bar background transparent
        backgroundColor: Colors.transparent,
        // Removes the shadow beneath the app bar
        elevation: 0,
      ),
      // Allows the body content to extend behind the app bar
      extendBodyBehindAppBar: true,
      // Main content of the scaffold
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/images/city.png', // Path to the image asset
            fit: BoxFit.cover, // Ensures the image covers the entire screen
            width: double.infinity, // Makes the image span the full width
            height: double.infinity, // Makes the image span the full height
          ),
          // SafeArea ensures the child widget is positioned within safe screen boundaries
          SafeArea(
            child: child!, // Renders the child widget passed to CustomScaffold
          ),
        ],
      ),
    );
  }
}
