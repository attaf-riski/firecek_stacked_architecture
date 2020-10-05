import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieMessage extends StatelessWidget {
  final double height;
  final String title;
  final String lottiePath;
  LottieMessage(
      {this.lottiePath = 'assets/lottie/no_conn.json',
      this.height,
      this.title});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          children: [
            LottieBuilder.asset(
              '$lottiePath',
              width: MediaQuery.of(context).size.width / 2,
            ),
            verticalSpaceMedium,
            Text(title ?? 'No internet.')
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      height: height ?? MediaQuery.of(context).size.height,
    );
  }
}
