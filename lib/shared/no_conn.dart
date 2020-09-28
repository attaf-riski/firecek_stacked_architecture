import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: LottieBuilder.asset(
          'assets/lottie/no_conn.json',
          width: MediaQuery.of(context).size.width / 2,
        ),
      ),
      height: MediaQuery.of(context).size.height,
    );
  }
}
