import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class lloading extends StatelessWidget {
  const lloading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Lottie.network("https://assets9.lottiefiles.com/private_files/lf30_ptsrzumi.json") ,
      ),
    );
  }
}