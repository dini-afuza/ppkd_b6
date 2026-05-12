import 'package:flutter/material.dart';

class Gridview1Day10 extends StatelessWidget {
  const Gridview1Day10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView 1"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: [
          Image.asset("assets/images/kucing.jpeg", fit: BoxFit.cover),
          Image.asset("assets/images/kucing_2.avif", fit: BoxFit.cover),
          Image.asset("assets/images/kucing_3.jpeg", fit: BoxFit.cover),
          Image.asset("assets/images/kucing_4.jpg", fit: BoxFit.cover),
          Image.asset("assets/images/kucing_5.avif", fit: BoxFit.cover),
        ],
      ),
    );
  }
}
