import 'package:flutter/material.dart';

class ScaffoldDay7 extends StatelessWidget {
  const ScaffoldDay7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        actions: [Text("Keluar")],
        centerTitle: true,

        title: Text("Scaffold Bacth 6"),
      ),
      body: Text("Nama Saya"),
    );
  }
}
