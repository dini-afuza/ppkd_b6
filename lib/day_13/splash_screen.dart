import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_13/textform.dart';
import 'package:ppkd_b6/extension/navigator.dart';

class SplashScreenDay13 extends StatelessWidget {
  const SplashScreenDay13({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/images/kucing_3.jpeg")),
          ElevatedButton(
            onPressed: () {
              // context.pushNamed("/login");
              // context.push(TextRichDay13());
              context.push(TextFormDay13());
            },
            child: Text("Ke halaman login"),
          ),
        ],
      ),
    );
  }
}
