import 'package:flutter/material.dart';

class ListtileDay10 extends StatelessWidget {
  const ListtileDay10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListTile"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/images/kucing_3.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("Nama Saya"),
                  subtitle: Text("Alamat Saya"),
                  trailing: Icon(Icons.arrow_forward),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
