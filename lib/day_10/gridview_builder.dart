import 'package:flutter/material.dart';

class Gridview2Day10 extends StatelessWidget {
  const Gridview2Day10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView 1"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [Text("500"), Text("Following")],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [Text("2k"), Text("Followers")],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [Text("900"), Text("Likes")],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  "assets/images/kucing.jpeg",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),

      // GridView.count(
      //   physics: BouncingScrollPhysics(),
      //   crossAxisCount: 3,
      //   mainAxisSpacing: 2,
      //   crossAxisSpacing: 2,
      //   children: [
      //     Image.asset("assets/images/kucing.jpeg", fit: BoxFit.cover),
      //     Image.asset("assets/images/kucing_2.avif", fit: BoxFit.cover),
      //     Image.asset("assets/images/kucing_3.jpeg", fit: BoxFit.cover),
      //     Image.asset("assets/images/kucing_4.jpg", fit: BoxFit.cover),
      //     Image.asset("assets/images/kucing_5.avif", fit: BoxFit.cover),
      //   ],
      // ),
    );
  }
}
