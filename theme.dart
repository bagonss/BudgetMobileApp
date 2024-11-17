import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light, 
  primary: Color.fromARGB(255, 255, 193, 7),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    secondary: Color.fromARGB(255, 255, 229, 149),
    onSecondary: Color.fromARGB(255, 255, 255, 255),
    error: Color.fromARGB(255, 186, 26, 26),
    onError: Color.fromARGB(255, 255, 255, 255),
    shadow: Color.fromARGB(0, 0, 0, 0),
    outlineVariant: Color.fromARGB(255, 182, 182, 182),
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Color.fromARGB(0,0,0,0)
    );

  const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 6, 26, 42),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    secondary: Color.fromARGB(255, 16, 68, 110),
    onSecondary: Color.fromARGB(255, 255, 255, 255),
    error: Color.fromARGB(255, 186, 26, 26),
    onError: Color.fromARGB(255, 255, 255, 255),
    shadow: Color.fromARGB(0, 0, 0, 0),
    outlineVariant: Color.fromARGB(255, 182, 182, 182),
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Color.fromARGB(0,0,0,0)
    );

    ThemeData lightMode = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: lightColorScheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            Colors.black),
          foregroundColor:
          WidgetStateProperty.all<Color>(Colors.white),
          elevation: WidgetStateProperty.all<double>(5.0),
          padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 20, vertical:18)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  
    ThemeData darkMode = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
    );
    