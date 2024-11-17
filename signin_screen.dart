import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobilebuild/screens/home_screen.dart';
import 'package:mobilebuild/widgets/custom_scaffold.dart';
import 'package:mobilebuild/screens/signup_screen.dart';

import '../theme/theme.dart';



class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formSignInKey = GlobalKey <FormState>();
  bool rememberPassword = true;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white70,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formSignInKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: darkColorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                       String pattern =
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                          RegExp regex = RegExp(pattern);

                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        hintText: 'Enter Email',
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color:Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        hintText: 'Enter Password',
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color:Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                Row(
                  children: [
                    Checkbox(
                      value: rememberPassword, 
                      onChanged: (bool? value) {
                        setState(() {
                          rememberPassword = value!;
                        });
                      },
                      activeColor: darkColorScheme.primary,
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(
                        color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                      GestureDetector(
                        child: Text(
                          'Forget password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkColorScheme.primary,
                          ),
                        ),
                      ),
                  
                   const SizedBox(
                    height: 25,
                   ),
                   SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      if (_formSignInKey.currentState!.validate() &&
                        rememberPassword) {
                           ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please Wait, signing in...'),
                                ),
                           );
                            // Navigate to the BudgetAnalyticsScreen after login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                        } else if (!rememberPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please Remember Password!')),
                          );
                        }
                    }, 
                    child: const Text('Sign In'),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0, 
                          horizontal: 10,
                          ),
                          child: Text(
                            'Sign up With',
                            style: TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.7,
                            color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Brand(Brands.facebook),
                          Brand(Brands.twitter),
                          Brand(Brands.google),
                          Brand(Brands.apple_logo),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // don't have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
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
}
