import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilebuild/screens/signin_screen.dart';
import 'package:mobilebuild/widgets/custom_scaffold.dart';
import '../theme/theme.dart';

/// Allows users to reset their password by entering their email.
/// A password reset email is sent to the user if their email is registered.
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Controller to handle the email input field.
  final TextEditingController emailController = TextEditingController();

  // GlobalKey to uniquely identify and validate the form.
  final _formKey = GlobalKey<FormState>();

  /// Sends a password reset email to the entered email address.
  /// If the email is not found, displays an error message.
  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      // Show success message
      _showSnackBar(
        "Password Reset Email has been sent!",
        Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        // Show error message for non-existent email
        _showSnackBar(
          "No user found for that email.",
          Colors.red,
        );
      }
    }
  }

  /// Displays a SnackBar with a custom message and background color.
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Spacer(), // Adds space to align content in the center
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey, // Associates the form with the key for validation
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header text
                      Text(
                        'Password Recovery',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: darkColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email input field
                      _buildTextField(
                        controller: emailController,
                        label: 'Email',
                        hintText: 'Enter your email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      // Submit button to send the reset email
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            resetPassword();
                          }
                        },
                        child: const Text('Send Email'),
                      ),
                      const SizedBox(height: 25),
                      // Navigation prompt for existing users
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.black45),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SigninScreen()),
                              );
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable text field widget for the form.
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator, // Validates the input based on the provided function
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black26),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
