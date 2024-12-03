import 'package:flutter/material.dart';

/// Light Color Scheme
/// Defines a color palette for the light theme of the app using `ColorScheme`.
const lightColorScheme = ColorScheme(
  brightness: Brightness.light, // Indicates light mode
  primary: Color.fromARGB(255, 255, 193, 7), // Main brand color for light mode
  onPrimary: Color.fromARGB(255, 255, 255, 255), // Text/icon color on primary surfaces
  secondary: Color.fromARGB(255, 255, 229, 149), // Secondary brand color
  onSecondary: Color.fromARGB(255, 255, 255, 255), // Text/icon color on secondary surfaces
  error: Color.fromARGB(255, 186, 26, 26), // Color for error messages or elements
  onError: Color.fromARGB(255, 255, 255, 255), // Text/icon color on error surfaces
  shadow: Color.fromARGB(0, 0, 0, 0), // Transparent shadow color
  outlineVariant: Color.fromARGB(255, 182, 182, 182), // Color for outlines/borders
  surface: Color.fromARGB(255, 255, 255, 255), // Background color for surfaces
  onSurface: Color.fromARGB(0, 0, 0, 0), // Text/icon color on surfaces (transparent in this case)
);

/// Dark Color Scheme
/// Defines a color palette for the dark theme of the app using `ColorScheme`.
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark, // Indicates dark mode
  primary: Color.fromARGB(255, 6, 26, 42), // Main brand color for dark mode
  onPrimary: Color.fromARGB(255, 255, 255, 255), // Text/icon color on primary surfaces
  secondary: Color.fromARGB(255, 16, 68, 110), // Secondary brand color
  onSecondary: Color.fromARGB(255, 255, 255, 255), // Text/icon color on secondary surfaces
  error: Color.fromARGB(255, 186, 26, 26), // Color for error messages or elements
  onError: Color.fromARGB(255, 255, 255, 255), // Text/icon color on error surfaces
  shadow: Color.fromARGB(0, 0, 0, 0), // Transparent shadow color
  outlineVariant: Color.fromARGB(255, 182, 182, 182), // Color for outlines/borders
  surface: Color.fromARGB(255, 255, 255, 255), // Background color for surfaces
  onSurface: Color.fromARGB(0, 0, 0, 0), // Text/icon color on surfaces (transparent in this case)
);

/// Light Mode Theme
/// Customizes the Flutter `ThemeData` for light mode.
ThemeData lightMode = ThemeData(
  useMaterial3: true, // Enables Material 3 design guidelines
  brightness: Brightness.light, // Specifies light mode
  colorScheme: lightColorScheme, // Applies the light color scheme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // Button background color
      backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
      // Button text color
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      // Button shadow elevation
      elevation: WidgetStateProperty.all<double>(5.0),
      // Button padding
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      // Button shape and border radius
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
);

/// Dark Mode Theme
/// Customizes the Flutter `ThemeData` for dark mode.
ThemeData darkMode = ThemeData(
  useMaterial3: true, // Enables Material 3 design guidelines
  brightness: Brightness.dark, // Specifies dark mode
  colorScheme: darkColorScheme, // Applies the dark color scheme
);
