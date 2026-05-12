import 'package:flutter/material.dart';

class StackDay10 extends StatelessWidget {
  const StackDay10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack"),
        backgroundColor: Colors.lightBlueAccent,
      ),

      body: Row(
        children: [
          buildStack1(),
          buildStack1(),
          buildStack1(),
          buildStack1(),
          buildStack1(),
          buildStack1(),
          buildStack1(),
          buildStack1(),
          buildStack1(),
          buildStack1(),
          buildStack1(),
        ],
      ),
    );
  }

  Stack buildStack1() {
    return Stack(
      alignment: AlignmentGeometry.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        // Container(height: 500, width: 400, color: Colors.red),
        // Container(height: 350, width: 300, color: Colors.yellow),
        // Container(height: 250, width: 200, color: Colors.green),
        Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green,

            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.red, Colors.yellow, Colors.blue],
            ),
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: AssetImage("assets/images/kucing.jpeg"),
            // ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/images/kucing.jpeg",

              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          bottom: -16,
          child: Container(
            padding: EdgeInsets.all(4),
            color: Colors.red,
            child: Text("LIVE"),
          ),
        ),
      ],
    );
  }
}
