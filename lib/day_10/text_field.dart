import 'package:flutter/material.dart';

class TextFieldDay10 extends StatelessWidget {
  const TextFieldDay10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text("Nama"),

            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],

                border: OutlineInputBorder(),
              ),
            ),
            Text("Nomor HP"),

            TextField(
              decoration: InputDecoration(
                hintText: "Masukkan Nomor HP",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Text("Email"),
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Masukkan Email",

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                  borderRadius: BorderRadius.circular(12),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Text("Password"),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.key),
              ),
            ),
            Text("Konfirmasi Password"),
            TextField(
              obscureText: true,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                hintText: "Masukkan Konfirmasi Password",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: Icon(Icons.visibility),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
