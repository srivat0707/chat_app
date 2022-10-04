import 'package:flutter/material.dart';
class homecomming extends StatelessWidget {
  const homecomming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(children: [
        Container(
          height: 180,
          color: Colors.blue,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 211, 209),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(80),topRight: Radius.circular(80))
            ),
          ),
        ),
      ]),
    );
  }
}