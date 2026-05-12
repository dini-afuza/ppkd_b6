import 'package:flutter/material.dart';

class SingleChildScrollViewDay10 extends StatelessWidget {
  const SingleChildScrollViewDay10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SingleChildScrollView"),
        backgroundColor: Colors.lightBlueAccent,
      ),

      body: Column(
        children: [
          SingleChildScrollView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildstack2(),
                buildstack2(),
                buildstack2(),
                buildstack2(),
                buildstack2(),
                buildstack2(),
                buildstack2(),
                buildstack2(),
                buildstack2(),
                buildstack2(),
                buildstack2(),
              ],
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              // clipBehavior: Clip.none,
              // scrollDirection: Axis.horizontal,
              child: Column(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Stack buildstack2() {
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

Widget buildName({String? number}) {
  return Column(
    children: [
      Row(
        children: [
          Image.asset("assets/images/kucing.jpeg", height: 50, width: 50),
          SizedBox(width: 8),
          Text("Habibie $number"),
        ],
      ),
      Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Image.asset("assets/images/kucing.jpeg"),
          Icon(Icons.favorite, color: Colors.red, size: 100),
        ],
      ),
      Row(
        children: [
          Icon(Icons.favorite),
          Icon(Icons.comment),
          Icon(Icons.share),
        ],
      ),
    ],
  );
}
