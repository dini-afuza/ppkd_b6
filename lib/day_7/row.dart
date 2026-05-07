import 'package:flutter/material.dart';

class RowDay7 extends StatelessWidget {
  const RowDay7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Row")),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 4,
            children: [
              Text(
                "Saldo sisa dikit",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              Text(
                "Bayar",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                ),
              ),
              Text("Top Up"),
              Text("Explor"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 4,
            children: [
              Text("Saldo sisa dikit"),
              Text("Bayar"),
              Text("Top Up"),
              Text("Explor"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 4,
            children: [
              Text("Saldo sisa dikit"),
              Text("Bayar"),
              Text("Top Up"),
              Text("Explor"),
            ],
          ),
        ],
      ),
    );
  }
}
