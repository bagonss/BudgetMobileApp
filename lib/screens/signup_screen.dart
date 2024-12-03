import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobilebuild/screens/home_screen.dart';
import 'package:mobilebuild/screens/signin_screen.dart';
import 'package:mobilebuild/widgets/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Features include input fields for full name, email, and password, with validation and a sign-up button.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Form key for validation
  final _formSignupKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // State to track whether the user agrees to data processing
  bool agreePersonalData = true;

  /// Registers the user with Firebase Authentication.
  /// Shows a success or error message based on the result.
  Future<void> registration() async {
    try {
      // Simulate successful registration
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Registered Successfully",
          style: TextStyle(fontSize: 20.0),
        ),
      ));
      // Navigate to the HomeScreen after registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = e.code == 'weak-password'
          ? "Password Provided is too Weak"
          : e.code == "email-already-in-use"
              ? "Account Already Exists"
              : "Registration Failed";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          message,
          style: const TextStyle(fontSize: 18.0),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Spacer(), // Adds spacing at the top
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
                  key: _formSignupKey, // Associates the form with the key for validation
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title text
                      const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      // Full Name input field
                      _buildTextField(
                        controller: fullnameController,
                        label: 'Full Name',
                        hintText: 'Enter Full Name',
                        validatorMessage: 'Please enter Full Name',
                      ),
                      const SizedBox(height: 25.0),
                      // Email input field
                      _buildTextField(
                        controller: emailController,
                        label: 'Email',
                        hintText: 'Enter Email',
                        validatorMessage: 'Please enter Email',
                      ),
                      const SizedBox(height: 25.0),
                      // Password input field
                      _buildTextField(
                        controller: passwordController,
                        label: 'Password',
                        hintText: 'Enter Password',
                        obscureText: true,
                        validatorMessage: 'Please enter Password',
                      ),
                      const SizedBox(height: 25.0),
                      // Checkbox to agree to personal data processing
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (value) => setState(() {
                              agreePersonalData = value!;
                            }),
                          ),
                          const Text('I agree to the processing of '),
                          const Text(
                            'Personal data',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      // Sign Up button
                      ElevatedButton(
                        onPressed: () {
                          if (_formSignupKey.currentState!.validate() &&
                              agreePersonalData) {
                            registration();
                          } else if (!agreePersonalData) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please agree to the processing of personal data',
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Sign up'),
                      ),
                      const SizedBox(height: 30.0),
                      // Divider with "Sign up with"
                      _buildDividerWithText('Sign up with'),
                      const SizedBox(height: 30.0),
                      // Social media icons row
                      _buildSocialMediaRow(),
                      const SizedBox(height: 25.0),
                      // Prompt to navigate to Sign In screen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SigninScreen(),
                              ),
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
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

  /// Reusable method for creating input fields.
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    required String validatorMessage,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) =>
          value == null || value.isEmpty ? validatorMessage : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  /// Creates a divider with text in the middle.
  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: Colors.grey.withOpacity(0.5), thickness: 0.7),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(text, style: const TextStyle(color: Colors.black45)),
        ),
        Expanded(
          child: Divider(color: Colors.grey.withOpacity(0.5), thickness: 0.7),
        ),
      ],
    );
  }

  /// Displays social media login icons in a row.
  Widget _buildSocialMediaRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Brand(Brands.facebook),
        Brand(Brands.twitter),
        Brand(Brands.google),
        Brand(Brands.apple_logo),
      ],
    );
  }
}
