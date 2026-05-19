import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_13/pop.dart';
import 'package:ppkd_b6/extension/navigator.dart';

class NavigatorDay13 extends StatelessWidget {
  const NavigatorDay13({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Navigator Day 13"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StateDay12()),
              // );
              context.push(NavigatorPopDay13());
            },
            child: Text("Navigator Push"),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StateDay12()),
              // );
              context.pushReplacement(NavigatorPopDay13());
            },
            child: Text("Navigator PushReplacement"),
          ),

          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StateDay12()),
              // );
              context.pushAndRemoveAll(NavigatorPopDay13());
            },
            child: Text("Navigator PushRemoveAll"),
          ),
        ],
      ),
    );
  }
}
