import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobilebuild/screens/forget_password_screen.dart';
import 'package:mobilebuild/screens/home_screen.dart';
import 'package:mobilebuild/widgets/custom_scaffold.dart';
import 'package:mobilebuild/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/theme.dart';

/// It provides additional features like "Remember Me," "Forgot Password," and social media login options.
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // Controllers for email and password input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Key to validate the SignIn form
  final _formSignInKey = GlobalKey<FormState>();

  // State to track the "Remember Me" checkbox
  bool rememberPassword = true;

  /// Logs in the user with Firebase Authentication.
  /// Displays a success or error message based on the result.
  Future<void> userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Navigate to the HomeScreen upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = (e.code == 'user-not-found')
          ? "No User Found for that Email"
          : (e.code == 'wrong-password')
              ? "Wrong Password Provided by User"
              : "Authentication Failed";
      _showSnackBar(message, Colors.orangeAccent);
    }
  }

  /// Displays a SnackBar with a custom message and color.
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
                  key: _formSignInKey, // Associates the form with the key for validation
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title text
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: darkColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Email input field
                      _buildTextField(
                        controller: emailController,
                        label: 'Email',
                        hintText: 'Enter Email',
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 25),
                      // Password input field
                      _buildTextField(
                        controller: passwordController,
                        label: 'Password',
                        hintText: 'Enter Password',
                        obscureText: true,
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 25),
                      // "Remember Me" and "Forgot Password" options
                      _buildRememberMeRow(),
                      const SizedBox(height: 25),
                      // Sign In button
                      ElevatedButton(
                        onPressed: () {
                          if (_formSignInKey.currentState!.validate() && rememberPassword) {
                            _showSnackBar('Please Wait, signing in...', Colors.green);
                            userLogin();
                          } else if (!rememberPassword) {
                            _showSnackBar('Please Remember Password!', Colors.red);
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                      const SizedBox(height: 25),
                      // Divider with "Sign up With"
                      _buildDividerWithText('Sign up With'),
                      const SizedBox(height: 30),
                      // Social media login options
                      _buildSocialMediaRow(),
                      const SizedBox(height: 25),
                      // Sign Up prompt
                      _buildSignUpPrompt(),
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

  /// Creates a reusable input field for forms.
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*', // Character used to obscure text
      validator: validator, // Validation logic
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

  /// Creates the "Remember Me" row with a checkbox and "Forgot Password" option.
  Widget _buildRememberMeRow() {
    return Row(
      children: [
        Checkbox(
          value: rememberPassword,
          onChanged: (value) => setState(() {
            rememberPassword = value!;
          }),
          activeColor: darkColorScheme.primary,
        ),
        const Text('Remember me', style: TextStyle(color: Colors.black45)),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPassword()),
            );
          },
          child: Text(
            'Forgot password?',
            style: TextStyle(fontWeight: FontWeight.bold, color: darkColorScheme.primary),
          ),
        ),
      ],
    );
  }

  /// Creates a divider with text for visual separation.
  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.withOpacity(0.5), thickness: 0.7)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(text, style: const TextStyle(color: Colors.black26)),
        ),
        Expanded(child: Divider(color: Colors.grey.withOpacity(0.5), thickness: 0.7)),
      ],
    );
  }

  /// Displays social media login buttons.
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

  /// Displays a prompt for users to sign up if they don't have an account.
  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(color: Colors.black45)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: Text(
            'Sign up',
            style: TextStyle(fontWeight: FontWeight.bold, color: darkColorScheme.primary),
          ),
        ),
      ],
    );
  }

  /// Validates the email input.
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter Email';
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!regex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  /// Validates the password input.
  String? _validatePassword(String? value) {
    return (value == null || value.isEmpty) ? 'Please enter Password' : null;
  }
}
