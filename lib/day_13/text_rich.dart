import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_13/pop.dart';
import 'package:ppkd_b6/extension/navigator.dart';

class TextRichDay13 extends StatelessWidget {
  const TextRichDay13({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Text Rich Day 13"),
      ),
      body: Column(
        children: [
          Text.rich(
            TextSpan(
              text: "Sudah Punya Akun?",
              style: TextStyle(fontSize: 40),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context.push(NavigatorPopDay13()),
                  text: " Masuk disini",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    color: Colors.blue,
                    fontSize: 40,
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
