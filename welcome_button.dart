import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:mobilebuild/screens/signup_screen.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({super.key, this.buttonText, this.onTap, this.color, required Color textColor});
  final String? buttonText;
  final Widget? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e)=> onTap!,
            ),
          );
      },
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: color!,
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          )
          ),
        child: Text(
          buttonText!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          )),
      ),
    );
  }
}