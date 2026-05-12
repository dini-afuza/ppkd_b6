import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_10/single_child_scroll_view.dart';

class Listview1Day10 extends StatelessWidget {
  const Listview1Day10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView 1"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
        ],
      ),
    );
  }
}
