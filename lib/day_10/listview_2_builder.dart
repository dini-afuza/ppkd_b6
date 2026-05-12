import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_10/single_child_scroll_view.dart';

class ListviewBuilder2Day10 extends StatelessWidget {
  const ListviewBuilder2Day10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView 2 Builder"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: 100,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return buildstack2();
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            flex: 8,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return buildName(number: "${index + 1}");
              },
            ),
          ),

          SizedBox(height: 20),
          Expanded(
            flex: 8,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Container(height: 16, color: Colors.grey);
              },
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return buildName(number: "${index + 1}");
              },
            ),
          ),
        ],
      ),
    );
  }
}
